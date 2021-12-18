from brownie import FundMe
from .helpful_scripts import get_account

fund_me = FundMe[-1]
account = get_account()


def fund():
    entrace_fee = fund_me.getEntranceFee()
    print(f"Current entrance fee: {entrace_fee}")
    print("Funding")
    fund_me.fund({"from": account, "value": entrace_fee})


def withdraw():
    fund_me.withdraw({"from": account})


def main():
    fund()
    withdraw()
