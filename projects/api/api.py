import sys
sys.path.append('/home/ferran/gitrepo/raspstuff/libs/sensors/temperature/')
import bmp280

import flask
from flask import request, jsonify
import smbus
import time

app = flask.Flask(__name__)
app.config["DEBUG"] = False

@app.route('/', methods=['GET'])
def home():
    return '''
    <h1>An API that returns stuff</h1>
    <ul>
    <li><a href="/api/v1/temp">Temperature</a>: returns room temperature</li>
    <li><a href="/api/v1/finance/price/<stock>">Finance - price</a>: returns closing price for a stock</li>
    </ul>
    '''

@app.route('/api/v1/temp', methods=['GET'])
def temp():
    return jsonify(getData())

@app.route('/api/v1/finance/price/<ticker>', methods=['GET'])
def finance(ticker):
    import yfinance as yf
    c = yf.Ticker(ticker)
    return jsonify(c.info)

app.run(host='0.0.0.0')
