import json
import ccxt
import logging

import pandas as pd
import numpy as np

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

        if pair not in isstable:
            ask_price = tickers[pair]["ask"]
            allocation = (1 / len(pairs)) # Allocation buckets maken zodat meerdere trading bots kunnen opereren op hetzelfde account
            available_cash = ( cash * 0.975 ) # Keep some cash in reserve to accomodate for price fluctuations
            coin_amount =  (allocation * available_cash) / ask_price 
            coin_allocation[pair] = [round(coin_amount, 8), ask_price]
        else:
            pass
    
    return coin_allocation

def place_market_order(pairs):
    """ Place buy and sell ordered based on trend"""
    
    unfiltered_pairs = pairs["pair"].values
    market_down = pairs["percentage"].values[:100].mean() < 0
    
    filtered_pairs = filter_pairs(unfiltered_pairs)
    top_10 = filtered_pairs[:10]
    balance = EXCHANGE.fetch_balance()
    df_balance = pd.DataFrame(balance["free"].items(), columns=["token", "balance"])
    portfolio = df_balance[df_balance["balance"]>0]
        
    tickers = EXCHANGE.fetch_tickers()
    
    # Sell
    for token, value in dict(portfolio.values).items():
        if token != "BUSD": 
            coin = f"{token}/BUSD"
            bid_price = tickers[coin]["bid"]
            try:
                print(f"Sell: {coin}, Amount: {value}, Bid: {bid_price}")
                # EXCHANGE.create_market_sell_order(coin, value)
            except Exception as e:
                logging.warning(f"Could not sell Coin: {coin}, Amount: {value}, Bid:{bid_price}")
                logging.warning(e)
                
    cash = EXCHANGE.fetch_balance()["BUSD"]["free"]
    coin_allocation = split_cash(cash, top_10)

    # Buy
    for coin, value in coin_allocation.items():
        if market_down == False: # Check if overall market is down. If True, we will not reenter the market until next period
            try:
                print(f"Buy: {coin}, Amount: {value[0]}, Ask: {value[1]}")
                # EXCHANGE.create_market_buy_order(coin, value[0])
            except Exception as e:
                logging.warning(f"Could not buy Coin: {coin}, Amount: {value[0]}, Ask:{value[1]}")
                logging.warning(e)


    return None

def main():

    hours = 12 # In config file
    pairs = [key for key in EXCHANGE.fetch_tickers().keys() if "/BUSD" in key]
    
    df_pairs_sorted = select_pairs(pairs, hours)
    place_market_order(df_pairs_sorted)

if __name__=="__main__":
    main()