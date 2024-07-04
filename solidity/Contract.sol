// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    bool public a = true;
    bool public b = false;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint8 public a = 200;
    uint16 public b = 1000;
    uint256 public sum = a + b;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 30;
    int8 public b = -10;
    int16 public difference = a - b;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	bytes32 public msg1 = "Hello World";
    string public msg2 = "Lord Ranchoatos here crushing solidity powered by alchemy university!!!";
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum Foods { Apple, Pizza, Bagel, Banana }

	Foods public food1 = Foods.Apple;
	Foods public food2 = Foods.Pizza;
	Foods public food3 = Foods.Bagel;
	Foods public food4 = Foods.Banana;
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

    function increment() external{
        x = x+1;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint public x;
    constructor(uint _x){
        x = _x;
    }

    function increment() external{
        x = x+1;
    }

    function add(uint a) external returns(uint){
        return x + a;
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        console.log(secretMessage);
        return 794;
    }
}
