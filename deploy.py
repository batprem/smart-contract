import os
from dotenv import load_dotenv

from solcx import compile_standard
import json
from web3 import Web3


load_dotenv(override=True)

CONTRACT_FILE = "./contracts/SimpleStorage.sol"
CONTRACT_NAME = "SimpleStorage"

RPC_URI = "http://127.0.0.1:7545"
CHAIN_ID = 1337

OWNER_ADDRESS = os.environ["OWNER_ADDRESS"]
OWNER_PRIVATE_KEY = os.environ["OWNER_PRIVATE_KEY"]


with open(CONTRACT_FILE, "r") as file:
    simple_storage_file = file.read()

compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"./contracts/SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
            }
        },
    },
    solc_version="0.8.0",
)

with open("results.json", "w") as file:
    json.dump(compiled_sol, file)

# Get bytecode
bytecode = compiled_sol["contracts"][CONTRACT_FILE][CONTRACT_NAME]["evm"]["bytecode"][
    "object"
]

# Get ABI
abi = compiled_sol["contracts"][CONTRACT_FILE][CONTRACT_NAME]["abi"]

# Connecto ganache
w3 = Web3(Web3.HTTPProvider(RPC_URI))

# Create athe contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

# Nonce: Number only used once
# Anytime we make a transaction, our trancaction is hashed with a new Nonce
# Get the lastest transactoin
nonce = w3.eth.getTransactionCount(OWNER_ADDRESS)
print(nonce)

# 1. Build a transaction
# 2. Sign a transaction
# 3. Send a transaction
transaction = SimpleStorage.constructor().buildTransaction(
    {"chainId": CHAIN_ID, "from": OWNER_ADDRESS, "nonce": nonce}
)


signed_txn = w3.eth.account.sign_transaction(transaction, private_key=OWNER_PRIVATE_KEY)

# Send this signed transaction
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

# Working with the contract, you always need
# Contrant Address
# Contract ABI
simple_storage = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)

# Call -> Simulate making the call and getting a return value
# Transact -> Actually make a state change


# Just call a function, doesn't make stage change
print("Call")
print("Before retrieve")

retrieve = simple_storage.functions.retrieve()
output = retrieve.call()
print(output)

# Initial value of favorite number
# Call
print(simple_storage.functions.store(15).call())

print("After retrieve")

retrieve = simple_storage.functions.retrieve()
output = retrieve.call()
print(output)


print("Transaction")
print("Before retrieve")

retrieve = simple_storage.functions.retrieve()
output = retrieve.call()
print(output)

# Initial value of favorite number
# Call
# Create transaction
store_transaction = simple_storage.functions.store(15).buildTransaction(
    {"chainId": CHAIN_ID, "from": OWNER_ADDRESS, "nonce": nonce + 1}
)  # nonce can only be used only each transaction
# Sign transaction
signed_store_txn = w3.eth.account.sign_transaction(
    store_transaction, private_key=OWNER_PRIVATE_KEY
)
# Send transaction
send_store_tx = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)
# Wait transaction
tx_receipt = w3.eth.wait_for_transaction_receipt(send_store_tx)

print("After retrieve")

retrieve = simple_storage.functions.retrieve()
output = retrieve.call()
print(output)
