// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IHero {
    function alert() external;
}

contract Sidekick {
    function sendAlert(address hero) external {
        IHero(hero).alert();
    }
}
// =======call data: above interface

// 2. forming call data manually.
 // SPDX-License-Identifier: MIT
 // sidekick.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero) external {
        // TODO: fill in the function signature in the ""
        bytes4 signature = bytes4(keccak256("alert()"));

        (bool success, ) = hero.call(abi.encodePacked(signature));

        require(success);
    }
}


//hero.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Hero {
    bool public alerted;

    function alert() external {
        alerted = true;
    }
}