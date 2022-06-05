// SPDX-License-Identifier: MIT

pragma solidity >= 0.4.24;

// To imports files, the path is relative to the file
// it must be in the same folder, as example:
// import "./SimpleStorage.sol";
import "./SimpleStorage.sol";

contract FactoryPattern {
    SimpleStorage[] public simpleStructArray; 

    function createSimpleStorageContract() public  {
        // When we initialize a variable we need to specify the type
        SimpleStorage simpleStruct = new SimpleStorage();
        simpleStructArray.push(simpleStruct);
    }
 
    // function storageFStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
    //     // We can call the functions of the contract
    //     SimpleStorage(address(simpleStructArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    // }

    // function storageFSRetrieve(uint256 _simpleStorageIndex) public view returns (uint256) {
    //     // We can call the functions of the contract
    //     return SimpleStorage(address(simpleStructArray[_simpleStorageIndex])).retrieve();
    // }

    function storageFStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // We can call the functions of the contract
        simpleStructArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function storageFSRetrieve(uint256 _simpleStorageIndex) public view returns (uint256) {
        // We can call the functions of the contract
        return simpleStructArray[_simpleStorageIndex].retrieve();
    }
}
