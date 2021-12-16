from brownie import SimpleStorage, accounts, config


def read_contract():
    simple_storage = SimpleStorage[-1]
    # simple_storge = SimpleStorage.at("0x0E94b61949bb77321a61ee995ab914e094fa732a")
    # ABI
    print(simple_storage.retrieve())


def main():
    read_contract()
