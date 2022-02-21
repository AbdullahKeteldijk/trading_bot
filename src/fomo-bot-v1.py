import base64

import json
import ccxt
import logging

import pandas as pd
import numpy as np

from get_top_crypto import get_top_crypto
from binance.client import Client

config = json.load(open('config.json'))

EXCHANGE = ccxt.binance({
    "apiKey": config["BINANCE_API_KEY"],
    "secret": config["BINANCE_SECRET_KEY"]
})

def select_pairs(pairs, hours):
    """ Sort trading pairs by performance and return dataframe"""
    columns = ["Date", "Open", "High", "Low", "Close", "Volume"]
    
    pairs_perc = []

    for i, pair in enumerate(pairs):
        try:
            data = EXCHANGE.fetch_ohlcv(pair, "1h")
            df_temp = pd.DataFrame.from_records(data, columns=columns)
            df_temp.head(12)
            percentage = (df_temp["Close"].iloc[-1] / df_temp["Close"].iloc[-1-hours]) - 1
            pairs_perc.append([pair, percentage])
        except Exception as e:
            logging.warning(f"Could not fetch {pair}")
            logging.warning(f"{e}")
            

    df_pairs_perc = pd.DataFrame(pairs_perc, columns=["pair", "percentage"])
    df_pairs_perc = df_pairs_perc.sort_values(by=['percentage'], ascending=False)
    
    return df_pairs_perc

def filter_pairs(pairs):
    ''' Filter pairs and return only top 200 pairs'''
    # Add filtering for top XXX coins ?
    
    pairs_data = EXCHANGE.fetch_tickers()
    filtered_pairs = []
    
    for pair in pairs: 
        # De if statement kan worden uitgebreid met logica om te zien of het volume substantieel is.
        if pairs_data[pair]["baseVolume"]>0 or pairs_data[pair]["quoteVolume"]>0:
            filtered_pairs.append(pair)
    
    return filtered_pairs

def split_cash(cash, pairs):
    
    tickers = EXCHANGE.fetch_tickers()
    coin_allocation = {}
    isstable = []
    
    for pair in pairs:
        try:
            ask_price = tickers[pair]["ask"]
            print("ask price:", ask_price)
            print("ask price > 0", ask_price > 0)
            print("ask price > 0.00000001", ask_price > 0.00000001)
            print("pair not in isstable", pair not in isstable)
            print("pair not in isstable or ask_price > 0", pair not in isstable and ask_price > 0)
            if pair not in isstable and ask_price > 0:                
                allocation = (1 / len(pairs)) # Allocation buckets maken zodat meerdere trading bots kunnen opereren op hetzelfde account
                available_cash = ( cash * 0.98 ) # Keep some cash in reserve to accomodate for price fluctuations
                coin_amount =  (allocation * available_cash) / ask_price 
                coin_allocation[pair] = [round(coin_amount, 8), ask_price]
            else:
                pass
        except Exception as e:
            print(f"Could not buy {pair}")
            print(e)
        
    return coin_allocation

def check_market_down():
    """ Check if the median of the 24hr return of the top 20 coins is down"""

    df_change = get_top_crypto().iloc[:20]["% Change"]

    if df_change.median() < 0:
        status = True
    else: 
        status = False

    return status

def sell_dust():
    """ Sell all dust for BNB and sell all BNB for BUSD"""
    
    binance_client = Client(api_key=config["BINANCE_API_KEY"], api_secret=config["BINANCE_SECRET_KEY"])
    balance = EXCHANGE.fetch_balance()
    
    not_keys = ['info', 'BNB', 'timestamp', 'datetime', 'free', 'used', 'total']
    tokens = [token for token in list(balance.keys()) if token not in not_keys if balance[token]["free"] > 0]
    
    try:
        binance_client.transfer_dust(asset=tokens)
    except Exception as e:
        print(e)

    if balance["BNB"]["free"] > 0:
        try:
            EXCHANGE.create_market_sell_order("BNB/BUSD", balance["BNB"]["free"])
            print("Sold BNB for BUSD")
        except Exception as e:
            print(e)

    return None

def place_market_order(pairs):
    """ Place buy and sell ordered based on trend"""
    
    unfiltered_pairs = pairs["pair"].values
    market_down = check_market_down() 
    
    filtered_pairs = filter_pairs(unfiltered_pairs)
    top_10 = filtered_pairs[:10]
    balance = EXCHANGE.fetch_balance()
    df_balance = pd.DataFrame(balance["free"].items(), columns=["token", "balance"]) # check toevoegen om te zien of het meer dan $10 is 
    portfolio = df_balance[df_balance["balance"]>0]
        
    tickers = EXCHANGE.fetch_tickers()
    
    # Sell
    for token, value in dict(portfolio.values).items():
        if token != "BUSD": 
            coin = f"{token}/BUSD"
            bid_price = tickers[coin]["bid"]
            try:
                print(f"Sell: {coin}, Amount: {value}, Bid: {bid_price}")
                EXCHANGE.create_market_sell_order(coin, value)
            except Exception as e:
                logging.warning(f"Could not sell Coin: {coin}, Amount: {value}, Bid:{bid_price}")
                logging.warning(e)

    print("sold")          
    cash = EXCHANGE.fetch_balance()["BUSD"]["free"]
    # sell_dust()
    print("cash")
    coin_allocation = split_cash(cash, top_10)
    print("allocation")
    
    # Buy
    for coin, value in coin_allocation.items():
        if market_down == False: # Check if overall market is down. If True, we will not reenter the market until next period
            print("Market up")
            try:
                print(f"Buy: {coin}, Amount: {value[0]}, Ask: {value[1]}")
                EXCHANGE.create_market_buy_order(coin, value[0])
                print("bought")
            except Exception as e:
                logging.warning(f"Could not buy Coin: {coin}, Amount: {value[0]}, Ask:{value[1]}")
                logging.warning(e)
        else:
            print("Market down")

    print("Done")
    
    return None

def main(event, context):

    hours = 12 # In config file
    pairs = [key for key in EXCHANGE.fetch_tickers().keys() if "/BUSD" in key]
    
    df_pairs_sorted = select_pairs(pairs, hours)
    place_market_order(df_pairs_sorted)

    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    print(pubsub_message)

if __name__=="__main__":
    main(event, context)
