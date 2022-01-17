// SPDX-License-Identifier: MIT
// Add License
// Store some information on Blockchain

pragma solidity >=0.6.0 <0.9.0;

// `contract` can be figured as `class` in OOP
contract SimpleStorageV2 {
    uint256 public favoriteNumber;
    bool favoriteBool;
    bool favoriteBool2;

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

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function retrieve_plus_1() public view returns (uint256) {
        return favoriteNumber + 1;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // Push a person to people
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        // Add to mapping
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
