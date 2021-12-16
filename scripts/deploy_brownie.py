import os
from brownie import accounts, config, SimpleStorage  # Can be import directly


def deploy_simple_storage():
    account = accounts.add(config["wallet"]["from_key"])
    simple_storage = SimpleStorage.deploy({"from": account})
    stored_value = simple_storage.retrieve()

    print(f"Stored value: {stored_value}")
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1)
    update_stored_value = simple_storage.retrieve()
    print(f"Stored value: {update_stored_value}")
    pass


def main():
    deploy_simple_storage()
