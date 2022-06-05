// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.9.0;

import "./priceconverter.sol";

contract FundMe {
  using PriceConverter for uint256;

  uint256 public minUsd;

  address[] public funders; 

  mapping(address => uint256) public addressToAmountFunded; 
  // constructor is called when the contract is created
  // it is called with the same arguments as the contract

  address public ownerAddress; 

  constructor(){ 
    minUsd = 50 * 1e18; 
    ownerAddress = msg.sender;
  }

  // to make a function payable, we need to add the payable modifier
  function fund() public payable{
    // require at least 1 ether to be sent = 1e18 is equal to 1 * 10 ** 18
    // we also can return a message if the transaction is not successful
    require(msg.value.getConversionRate() >= minUsd, "You need to send at least 1 ether");
    // msg.sender is the address of the sender
    // msg.value is the amount of ether sent
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = msg.value; 
  }
  
  
  function withdraw() public onlyOwner {
    require(msg.sender == ownerAddress, "Only the contract owner can withdraw");

    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
      address funder = funders[funderIndex]; 
      addressToAmountFunded[funder] = 0; 
    }

    // reset the array 
    funders = new address[](0);
    // send ether to the contract

    // we can use three different ways to send ether
    // 1. send ether to an address
    // 2. send ether to the contract itself
    // 3. send ether to the contract itself and a function

    // and we can use 3 different functions to send ether
    // 1. transfer
    // 2. send
    // 3. call 

    // payable(msg.sender) = payable address
    // payable(msg.sender).transfer(address(this).balance);

    // bool isSuccess = payable(msg.sender).send(address(this).balance);
    // require(isSuccess, "Failed to send ether");


    // at this moment call is the most recommended way to send ether
    // in the most part ot the cases. 
    (
      bool callSucess, 
    /**bytes memory dataReturn*/
    ) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSucess, "Failed to call");
  }

  // modifiers
  modifier onlyOwner{
    require(msg.sender == ownerAddress, "Only the contract owner can perform this action");
    // onlyscore is to call the rest of the function
    _;
  }
}
