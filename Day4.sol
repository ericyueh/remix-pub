//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Day4 {
    // Boolean
    bool public isMerge = true;

    //integer
    int public I = -123;
    uint public U = 999999;

    //address
    address public Ericaddr = 0x000554A2D546D8b84bf7C3FDDdbF17755298dC37;
    address payable public PayEricAddr = payable(Ericaddr);

    //Enum
    enum Color {Blue, Green} Color public C = Color.Green;

}
