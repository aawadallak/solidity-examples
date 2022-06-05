// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
   AggregatorV3Interface internal priceFeed;

  // dictionary of addresses to uint256
  mapping (address => uint256) public balances;

  uint256 public minimumContribution = 50 * 1e18;

  address[] public funders; 

  // constructor is called when the contract is created
  // it is called with the same arguments as the contract
  constructor(){ 
    priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 
  } 

  // to make a function payable, we need to add the payable modifier
  function fund() public payable{
    // require at least 1 ether to be sent = 1e18 is equal to 1 * 10 ** 18
    // we also can return a message if the transaction is not successful
    require(getConversionRate(msg.value) >= minimumContribution, "You need to send at least 1 ether");
    // msg.sender is the address of the sender
    // msg.value is the amount of ether sent
    funders.push(msg.sender); 
  }

  function convertPriceToEther(int _price) internal pure returns(uint256) {
    // type casting from int to uint
    // uint256 is the same as int256
    return uint256(_price * 1e10); 
  }

  function getPrice() public view returns(uint256) { 
       (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        return convertPriceToEther(price);
  } 

    function getConversionRate(uint256 _etherAmount) public view returns(uint256) {
    uint256 etherPrice = getPrice();
    return (_etherAmount * etherPrice) / 1e18;
  }

  function getVersion() public view returns(uint256){ 
    return priceFeed.version(); 
  }
  
  function withdraw()public {}
}
