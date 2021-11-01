#!/home/een023/.pyenv/versions/3.9.2/envs/crypto/bin/python

from subprocess import check_output
import ccxt

BINANCE_DICT={
        "API_KEY": check_output('pass Crypto/Binance/API_KEY', shell=True).decode("utf-8")[:-1],
        "SECRET_KEY": check_output('pass Crypto/Binance/SECRET_KEY', shell=True).decode("utf-8")[:-1]
}

# COINBASE_DICT={
#         "API_KEY": check_output('pass Crypto/Coinbase/API_KEY', shell=True).decode("utf-8")[:-1],
#         "SECRET_KEY": check_output('pass Crypto/Coinbase/SECRET_KEY', shell=True).decode("utf-8")[:-1]
# }

GATEIO_DICT={
        "API_KEY": check_output('pass Crypto/Gateio/API_KEY', shell=True).decode("utf-8")[:-1],
        "SECRET_KEY": check_output('pass Crypto/Gateio/SECRET_KEY', shell=True).decode("utf-8")[:-1]
}

GATEIOv4_DICT={
        "API_KEY": check_output('pass Crypto/Gateio_v4/API_KEY', shell=True).decode("utf-8")[:-1],
        "SECRET_KEY": check_output('pass Crypto/Gateio_v4/SECRET_KEY', shell=True).decode("utf-8")[:-1]
}

LOGIN_B = BINANCE_DICT
# LOGIN_C = COINBASE_DICT
# LOGIN_CP = COINBASE_PRO_DICT
LOGIN_G = GATEIO_DICT
# LOGIN_Gv4 = GATEIOv4_DICT
# LOGIN_K = KRAKEN_DICT
LOGINS = [
    LOGIN_B,
    # LOGIN_C,
    # LOGIN_CP,
    LOGIN_G,
    # LOGIN_Gv4,
    # LOGIN_K
]
websites = [
    'binance',
    # 'coinbase',
    # 'coinbasepro',
    'gateio',
    # 'gateio',
    # 'kraken'
]

def check_balance():
    for w, login in zip(websites, LOGINS):
        CLASS = getattr(ccxt, w)
        exchange = CLASS({
            'apiKey': login['API_KEY'],
            'secret': login['SECRET_KEY']
        })
        balance = exchange.fetch_balance()
        print(f'Balance on {w}')
        try:
            print(f"BTC: {balance['total']['BTC']}")
            print(f"BNB: {balance['total']['BNB']}")
            print(f"XLM: {balance['total']['XLM']}")
        except Exception:
            bt = balance['total']
            print(bt)

if __name__ == '__main__':
    check_balance()
