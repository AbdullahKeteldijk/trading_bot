import json
import base64
import ccxt
import pandas as pd

import logging
import os
import cloudstorage as gcs
import webapp2

from google.appengine.api import app_identity



def fetch_portfolio(exchange):
    ''' Request top 10 holdings on exchange and save to CSV'''

    balance = exchange.fetch_balance()
    tickers = exchange.fetch_tickers()
    date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    portfolio = pd.DataFrame(balance["free"].items(), columns=["token", "amount"]) 
    value_list = []

    for ticker, amount in portfolio.values:
        if ticker == "BUSD":
            value = amount
        else:
            try:
                value = tickers[f"{ticker}/BUSD"]["ask"] * amount
            except:
                value = 0
        value_list.append(value)

    portfolio["value"] = value_list    
    portfolio["value"] = date
    portfolio = portfolio.sort_values("value", ascending=False).iloc[:11]
    portfolio.to_csv(f"../data/logger/portfolio-template-{date}.csv", index=False)


def main(event, context):

    config = json.load(open('../logger_config.json'))
    exchange = ccxt.binance({
        "apiKey": config["BINANCE_API_KEY"],
        "secret": config["BINANCE_SECRET_KEY"]
    })
    fetch_portfolio(exchange)

    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    print(pubsub_message)

if __name__ == "__main__":
    main(event, context)
