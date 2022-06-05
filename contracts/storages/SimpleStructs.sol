// SPDX-License-Identifier:MIT    
pragma solidity >=0.5.0 <0.9.0;

contract SimpleStruct {
    struct People { 
        uint256 age;
        string name;
    }

    // Example how to use a struct with a constructor
    // People public person = People({age: 0, name: ""}); 


    // We can have Dynamic Arrays as well as Static Arrays
    // Dynamic Arrays are arrays that can grow and shrink
    // Static Arrays are arrays that can only grow

    // Example of people array
    People[] public people;

    // What is the difference between memory and calldata
    function addPerson(uint256 _age, string memory _name) public {
        people.push(People({age: _age, name: _name}));
    }

    // Example of a map
    mapping(string => People) public peopleMap;

    function adddPersonToMap(string memory _name, uint256 _age) public {
        peopleMap[_name] = People({age: _age, name: _name});
    }

    //find a person in the map and check if it exists
    function findPersonByName(string memory _name) public view returns (People memory) {
        require(peopleMap[_name].age != 0, "Person not found");
        return peopleMap[_name];
    }

    function findPerson(string memory _name) public view returns (People memory) {
        return peopleMap[_name];
    }
}
