// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	constructor() payable {
		require(msg.value >= 1 ether, "Not enough ether sent");
	}
}

// Create a public function withdraw that will withdraw all funds from the contract and send them to the deployer of the contract.
// Require that only the deployer of the contract be allowed to call this function. For all other addresses, this function should revert.
// 💡 The deployer of the contract is msg.sender of the constructor.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	address owner;

	constructor() payable {
		owner = msg.sender;
		require(msg.value >= 1 ether, "Not enough ether sent");
	}

	function withdraw() public {
		require(msg.sender == owner);
		payable(msg.sender).transfer(address(this).balance);
	}
}

// FUNCTION MODIFIER
// Update the onlyOwner modifier to require that only the owner address can call these functions without reverting.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	uint configA;
	uint configB;
	uint configC;
	address owner;

	constructor() {
		owner = msg.sender;
	}

	function setA(uint _configA) public onlyOwner {
		configA = _configA;
	}

	function setB(uint _configB) public onlyOwner {
		configB = _configB;
	}

	function setC(uint _configC) public onlyOwner {
		configC = _configC;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		// underscore runs the function body
		_;
	}
}
