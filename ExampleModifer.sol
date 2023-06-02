// SPDX-License-Identifier:MIX
pragma solidity »=.7.0 -0.9.0;
contract ExanpleModifler{
  address public owner;
  uint public account;
  
  constructor(){ 
    owner = msg.sender;
    account = 0;
  }

  modifier onlyOwner(uint _account){
    require(msg.sender == owner, "only owner");
    require(_account > 100, "valid 100");
    _;
  }

  function updateAccount(uint _account) public onlyowner(_account){
    account = _account;
  }

}
