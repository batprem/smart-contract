// SPDX-License-Identifier: MIT
// Add License
// Store some information on Blockchain

pragma solidity >=0.6.0 <0.9.0;

// `contract` can be figured as `class` in OOP
contract SimpleStorage {
    // Contents of contract
    // uint256 favoriteNumber = 5;
    // bool favoriteBool = false;
    // string favortieString = "String";
    // int256 favoriteInt = -5;
    // address favortieAddress = 0x75bd01a1608e68557a59f86856130bb7dbe6102e;
    // bytes32 favortieBytes = "cat";

    // this will get initialized to 0
    uint256 public favoriteNumber;
    bool favoriteBool;
    bool favoriteBool2;
    // `external` must called by other contracts
    // `public` make favoriteNumber seeable by outside, can be called by any
    // `internal` (default) can only be called by function inside the contract
    // `private` are only visible for the contract they are defined in and not in derived contracts
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People public person = People({favoriteNumber: 2, name: "test"});

    People[] public people; // Dynamic array People[1] for fixed
    mapping(string => uint256) public nameToFavoriteNumber; //mappig

    function store(uint256 _favoriteNumber) public returns (uint256) {
        favoriteNumber = _favoriteNumber;
        return favoriteNumber;
        // uint256 test = 4;
    }

    //`view` read state of blockchain (does make transaction)

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    //`pure` do some type of math must not have return
    function retrieve_plus_1() public view returns (uint256) {
        return favoriteNumber + 1;
    }

    function addPerson(
        string memory _name, // memory: Data will only be stored during the execution of the function
        // string storage _name, // storage: Data is persist after execution
        uint256 _favoriteNumber
    ) public {
        // Push a person to people
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        // Add to mapping
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
