// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// accessing the caller on a contract

contract Contract {
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    fallback() external payable {

    }
    
}