// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.9.0;

import "./priceconverter.sol";

contract FundMe {
  using PriceConverter for uint256;

  uint256 public minimumContribution = 50 * 1e18;

  address[] public funders; 

  mapping(address => uint256) public addressToAmountFunded; 
  // constructor is called when the contract is created
  // it is called with the same arguments as the contract


  // to make a function payable, we need to add the payable modifier
  function fund() public payable{
    // require at least 1 ether to be sent = 1e18 is equal to 1 * 10 ** 18
    // we also can return a message if the transaction is not successful
    require(msg.value.getConversionRate() >= minimumContribution, "You need to send at least 1 ether");
    // msg.sender is the address of the sender
    // msg.value is the amount of ether sent
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = msg.value; 
  }

  
  
  function withdraw()public {}
}
