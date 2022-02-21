import requests
import pandas as pd
import ftplib
import io
import re
import json
import datetime

try:
    from requests_html import HTMLSession
except Exception:
    print("""Warning - Certain functionality 
             requires requests_html, which is not installed.
             
             Install using: 
             pip install requests_html
             
             After installation, you may have to restart your Python session.""")

    
base_url = "https://query1.finance.yahoo.com/v8/finance/chart/"

def force_float(elt):
    
    try:
        return float(elt)
    except:
        return elt
        
def _convert_to_numeric(s):

    if "M" in s:
        s = s.strip("M")
        return force_float(s) * 1_000_000
    
    if "B" in s:
        s = s.strip("B")
        return force_float(s) * 1_000_000_000
    
    return force_float(s)

def get_top_crypto():
    
    '''Gets the top 100 Cryptocurrencies by Market Cap'''      

    session = HTMLSession()
    
    resp = session.get("https://finance.yahoo.com/cryptocurrencies?offset=0&count=100")
    
    tables = pd.read_html(resp.html.raw_html)               
                    
    df = tables[0].copy()

    
    df["% Change"] = df["% Change"].map(lambda x: float(str(x).strip("%").\
                                                               strip("+").\
                                                               replace(",", "")))
                                         
    del df["52 Week Range"]
    del df["Day Chart"]
    
    fields_to_change = [x for x in df.columns.tolist() if "Volume" in x \
                        or x == "Market Cap" or x == "Circulating Supply"]
    
    for field in fields_to_change:
        
        if type(df[field][0]) == str:
            df[field] = df[field].map(lambda x: _convert_to_numeric(str(x)))
            
            
    session.close()        
                
    return df

