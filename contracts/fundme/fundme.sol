// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.9.0;

import "./priceconverter.sol";

error NotOwner(); 

contract FundMe {
  using PriceConverter for uint256;

  // constants should be capitalized it is a convention
  uint256 public constant MININUM_USD = 50 * 1e18;

  address[] public funders; 

  mapping(address => uint256) public addressToAmountFunded; 
  // constructor is called when the contract is created
  // it is called with the same arguments as the contract

  // immutable is marked with the i_ prefix
  address public immutable i_ownerAddress; 

  constructor(){ 
    i_ownerAddress = msg.sender;
  }

  // to make a function payable, we need to add the payable modifier
  function fund() public payable{
    // require at least 1 ether to be sent = 1e18 is equal to 1 * 10 ** 18
    // we also can return a message if the transaction is not successful
    require(msg.value.getConversionRate() >= MININUM_USD, "You need to send at least 1 ether");
    // msg.sender is the address of the sender
    // msg.value is the amount of ether sent
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = msg.value; 
  }
  
  
  function withdraw() public onlyOwner {
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
    // payable(msg.sender).t ransfer(address(this).balance);

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
    if (msg.sender != i_ownerAddress){
      revert NotOwner(); 
    }

    // require(msg.sender == i_ownerAddress, "Only the contract owner can perform this action");
    // onlyscore is to call the rest of the function
    _;
  }

  // how to protect from people send ETH to contract without calling fund? 

  // recive will be called on low level interactions if the calldata is empty
  // otherwise it will call fallback if exists
  receive() external payable { 
    fund();
  }

  fallback() external payable { 
    fund();
  }
}
