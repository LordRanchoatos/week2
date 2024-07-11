// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address a, address b) payable {
        arbiter = a;
        beneficiary = b;
        depositor = msg.sender;
    }
    
}