// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Why is this a library and not abstract?
// Why not an interface?

library PriceConverter {
    //We could make this public, then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses#Sepolia%20Testnet
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (,int256 answer, , , ) = priceFeed.latestRoundData();
        //ETH/USD rate in 18 digit
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount)
    internal
    view returns (uint256)
    {
        uint256 ethprice = getPrice();
        uint256 ethAmountInUsd = (ethprice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}