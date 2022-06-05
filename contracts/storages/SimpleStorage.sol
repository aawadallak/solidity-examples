// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.24 <0.9.0;

/*
    uint storedData2 = 0;  
    bool storedData = false;
    string storedData1 = ""; 
    int storedData3 = 0;
    address storedData4 = 0x69b581Fa730D9bd817a412DCF2fA5531786c3c9e;  // this is a ETH ADDRESS
    bytes32 storedData5 = "cat"; 
*/

// A contract is similiar a class in JAVA
contract SimpleStorage{
    // If we didnt call it public
    // automatically it will be Internal 
    uint256 favoriteNumber; 

    // Public variable also have view functions

    // this is public because we want to call it from outside the contract
    // virtual means that it can be overwritten by the child contract
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    // View and Pure are functions that dont change the state of the contract
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    // Pure functions basically dont change the state of the contract
    // but they can be used to check if a value is valid 
    // or if a value is in a certain range
    // and execute some logic
    // and it can recieve input
    function mul(uint256 _input) public pure returns (uint256) {
        return _input * _input;
    }
}

/*
    Internal functions are functions that are visible to the contract but not to the outside world
    External functions are functions that are visible to other contracts
    Public functions are functions that are visible to the outside world
    Private functions are functions that are visible only to the contract
*/