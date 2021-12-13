// SPDX-License-Identifier: MIT //Add License
pragma solidity >=0.6.0 < 0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage{
    // Deploy contract from another contract
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
        // return address of contract SimpleStorage
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Store data into contract
        // required
        // Address
        // ABI (Application Binary Interface)
        SimpleStorage simpleStorage = SimpleStorage(
            address(
                simpleStorageArray[_simpleStorageIndex]
            )
        );
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // Get stored data
        SimpleStorage simpleStorage = SimpleStorage(
            address(
                simpleStorageArray[_simpleStorageIndex]
            )
        );
        return simpleStorage.retrieve();
    }
}