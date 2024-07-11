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

//alldata with signature.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero, uint enemies, bool armed) external {
        (bool success, ) = hero.call(
            abi.encodeWithSignature("alert(uint256,bool)", enemies, armed)
        );

        require(success);
    }
}

//abitrary alert
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function relay(address hero, bytes memory data) external {
        (bool success, ) = hero.call(data);

        require(success);
    }
}

//trige fallback
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function makeContact(address hero) external {
        // send over any calldata that doesnt match existing signatures!
        (bool success, ) = hero.call(
            abi.encodeWithSignature("")
        );

        require(success);
    }
}