// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.24 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// all the functions inside a library must be internal 
library PriceConverter { 

  function convertPriceToEther(int _price) internal pure returns(uint256) {
    // type casting from int to uint
    // uint256 is the same as int256
    return uint256(_price * 1e10); 
  }

  function getPrice() public view returns(uint256) { 
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 

       (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        return convertPriceToEther(price);
  } 

  function getConversionRate(uint256 _etherAmount) internal view returns(uint256) {
    uint256 etherPrice = getPrice();
    return (_etherAmount * etherPrice) / 1e18;
  }

  function getVersion() internal view returns(uint256){ 
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 

    return priceFeed.version(); 
  }
}