import os
import time
import json

import pandas as pd
import ccxt

import yahoo_fin.stock_info as yahoo
from progressbar import progressbar


class GetPairs:
    ''' This class collects all names of the top trading pairs'''
    
    def __init__(self):
        self.path = "data/market_cap"

    def _clean_list(self, dirty_list):
        ''' Remove items in list that contain special characters or lowercase letters'''

        clean_list = dirty_list.copy()
    #     clean_list = [str(i) for i in clean_list]
        dirty_items = [".", ",", '/', "$", "%", "!", "@"]

        for item in dirty_list:
            for dirty_item in dirty_items:
                try:
                    if dirty_item in item:
                        clean_list.remove(item)
                except Exception as e:
                    pass

            if item[1].islower() or item[1].isnumeric():
                try:
                    clean_list.remove(item)
                except Exception as e:
                    pass

        return clean_list

    def get_historic_top_crypto(self):
        ''' Returns top crypto currencies by market cap since 2016 (dependent on the data in path)
            
            The historic crypto data is a bit dirty and has to be cleaned with the _clean_list
            function. 
            
            returns:
                pair_list_clean: list - List of historical trading pairs
        '''

        pair_set = set()

        for filename in os.listdir(self.path):
            try:
                df_temp = pd.read_csv(f"data/market_cap/{filename}")
                pair_set = set.union(pair_set, set(df_temp['Ticker']))
            except KeyError:
                pass

        pair_list_dirty = list(pair_set)
        pair_list_dirty = [str(i) for i in pair_list_dirty]
        pair_list_clean = self._clean_list(pair_list_dirty)

        return pair_list_clean
    
    def get_current_top_crypto(self):
        ''' Get current 100 crypto trading pairs'''
        # Automatische check toevoegen om te zien of de ticker al in de lijst staat.
        top100 = yahoo.get_top_crypto()

        return list(top100['Symbol'])
    
    
    
    class FetchCryptoData:
    ''' This class requests data from the API of a specific exchange. 
        The API call will return the OHLCV data for a specified crypto trading pair (e.g. BTC/USD)
        
        params:
            pair: list - List trading pairs that need to be looked up
            timeframe: string - Time interval for data (e.g. 1m, 5m, 15m, 1h, 1d, 1wk, 1mo)
            start: int - Timestamp for the first record in the requested data
            req_number: int - Number of requests
            exchange: string - Name of the exchange (in lowercase)
            
    '''
    
    
    def __init__(self, pairs, timeframe, start, reduction, req_number, exchange):
        self.pairs = pairs
        self.timeframe = timeframe
        self.start = start
        self.reduction = reduction
        self.req_number = req_number
        self.exchange = exchange
        
        self.usdt_exchange = ['binance', 'huobi', 'kucoin']
        
        self.columns = ["Date", "Open", "High", "Low", "Close", "Volume"]
#         self.check_df = pd.DataFrame(columns=self.columns)

        
    def __get_exchange(self):
        ''' Get exchange API function'''
        exchanges = {
            "binance": ccxt.binance(),
            "ftx": ccxt.ftx(),
            "kraken": ccxt.kraken(),
            "bitfinex": ccxt.bitfinex(), # max 100 rows
            "huobi": ccxt.huobi(), # 
            "gateio": ccxt.gateio(), # max 100 rows
            "kucoin": ccxt.kucoin(),
            "bittrex": ccxt.bittrex(),
                    }
        return exchanges[self.exchange]
    
    def __change_pairs(self):
        ''' Changes trading pair name from */USD to */USDT'''
        # Moet logica inbouwen om USDTT te voorkomen
        return [pair.replace("USD", "USDT") for pair in self.pairs]
        
    def _download_data(self, pair, timestamp):
        ''' Downloads and saves trading pair data'''
        exchange = self.__get_exchange()
        
        data = exchange.fetch_ohlcv(pair, self.timeframe, timestamp)
        df = pd.DataFrame.from_records(data, columns=self.columns)
        
        pair_name = pair.replace("/", "-")
        timestamp_name = int(timestamp/10000)
        self.save_directory = (f'data/request_{self.timeframe}'
                               f'/{self.exchange}_{pair_name}_{timestamp_name}.csv')

        return df
    
    def request_data(self):
        ''' Calls the _download_data function for a specified pair and timestamp. 
            
            If the request fails, the name of the failed pair is returned as the "failed" list. 
            This list can later be used to try and get the data from another exchange
            
            returns:
                success: list - A list of all the trading pairs that are downloaded
                failed: list - A list of all the trading pairs that failed to download
                timestamp_dict: dict - A dictionary of the earliest succesfully downloaded trading pair
        '''
        
        # Some exchanges only have */USDT trading pairs
        if self.exchange in self.usdt_exchange: 
            self.pairs = self.__change_pairs()
            
        pairs_slash = [x.replace("-", "/") for x in self.pairs]
        timestamp = self.start

        success = []
        failed = []
        timestamp_dict = {}
        error_dict = {}

        for pair in pairs_slash:
            try:
                for req in range(self.req_number):
                    time.sleep(10)
                    df = self._download_data(pair, timestamp)

                    if df.shape[0]<1:
                        error = f"Maximum amount of avalaible {pair} data retrieved from {self.exchange}"
                        error_dict[pair] = error
                        failed.append(pair)
                        break

                    df.to_csv(self.save_directory, index=False)

                    timestamp_dict[pair] = timestamp
                    timestamp -= self.reduction                    

    #             if df.values.all() != self.check_df.values.all(): # beetje omslagtig. Alternatief is om een self variable aan te maken
                success.append(pair)
                    
            except ccxt.BadSymbol as bs:
                print(f"Could not download {pair}")
                print(bs)
                error_dict[pair] = bs
                failed.append(pair)
                pass
            except ccxt.RateLimitExceeded as re:
                print(f"Too Many Requests {pair}")
                print(re)
                error_dict[pair] = re
                pass

        return success, failed, timestamp_dict, error_dict