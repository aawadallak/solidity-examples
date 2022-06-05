// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.24 <0.9.0;

import "./SimpleStorage.sol";

// Example of an innheritance contract
contract ExtraStorage is SimpleStorage{
    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber * 5; // Multiply the number by 5
        // call the store function of the parent contract
        SimpleStorage.store(favoriteNumber);
    }
}