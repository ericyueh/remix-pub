// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./yourtoken.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";

// Learn more about the ERC20 implementation 
// on OpenZeppelin docs: https://docs.openzeppelin.com/contracts/4.x/api/access#Ownable
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vendor is Ownable {

  // Our Token Contract
  Yourtoken yourToken;

  // token price for ETH
  uint256 public tokensPerEth = 100;  

  // set TokenTransfter indicator
  bool public isTknTransfer;

  // Event that log buy operation
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  constructor(address tokenAddress) {      
      yourToken = Yourtoken(tokenAddress);  
  }
    
  /**
  * @notice Allow users to buy token for ETH
  */
  function buyTokens() public payable returns (uint256 tokenAmount) {   
    require(msg.value > 0, "Send ETH to buy some tokens");  

    uint256 amountToBuy = msg.value * tokensPerEth;

    // check if the Vendor Contract has enough amount of tokens for the transaction
      uint256 vendorBalance = yourToken.balanceOf(address(this));
      require(vendorBalance >= amountToBuy, "Vendor contract has not enough tokens in its balance");

    // Transfer token to the msg.sender
    (bool sent) = yourToken.transfer(msg.sender, amountToBuy);
    require(sent, "Failed to transfer token to user");

    // set TokenTransfter indicator
    isTknTransfer = true;

    // emit the event
    emit BuyTokens(msg.sender, msg.value, amountToBuy);

    return amountToBuy;
  }

  /**
  * @notice Allow the owner of the contract to withdraw ETH
  */
  function withdraw() public onlyOwner {
    uint256 ownerBalance = address(this).balance;
    require(ownerBalance > 0, "Owner has not balance to withdraw");

    (bool sent,) = msg.sender.call{value: address(this).balance}("");
    require(sent, "Failed to send user balance back to the owner");
  }

  /**
  * @notice check balance of eth in this contract
  */
  function getBalance() external view returns (uint256) {
      return address(this).balance;
  }

  /**
  * @notice check balance of eth in this contract
  */
  function getTokenBalance() external view returns (uint256) {
      return yourToken.balanceOf(address(this));
  }
}
