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

//tip the owner of the contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    fallback() external payable {

    }

    function tip()external payable{
        owner.call{ value: msg.value }("");
    }
    
}

//sending from the contract using the this keyword:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/console.sol";

contract Contract {
    address public owner;
    address public charity;
    constructor(address _charity){
        owner = msg.sender;
        charity = _charity;
    }

    fallback() external payable {

    }

    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public payable{
        console.log( address(this) );
        console.log( address(this).balance );
        (bool success, ) = charity.call{value: address(this).balance}("");
        require(success);
    }
    
}