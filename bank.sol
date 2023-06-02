// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract EricBank {
    // payable address can receive ether
    address payable public owner;

    // payable constructor can receive ether
    constructor() payable {
        owner = payable(msg.sender);
    } 

    function deposit() public payable{}

    function withdraw() public {
        // get the amount of ether stored in this contract
        uint amount = address(this).balance;
        
        // send all ether to owner
        // owner can receive ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "failed to send ether");  
    }

    function checkbalance() public view returns (uint balance) {
        return address(this).balance; 
    }


}
