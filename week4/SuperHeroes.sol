// Inheritance
// Traditionally, inheritance is when one class copies (or inherits) functionality from another class.

// 📖 Throughout this lesson you'll see the terms base and derived. Simply put, the derived class inherits from the base class.

// For Solidity, we'll be talking about inheritance for Contracts instead of Classes. However, the concept is the same!

// It's quite easy to inherit contracts in Solidity. Let's see an example:

// contract Base {
// 	uint public value = 10;

// 	function changeValue(uint _value) external {
// 		value = _value;
// 	}
// }

// contract Derived is Base {
//     // inherits everything from base contract!
// }
// ☝️ In this example the Derived inherits both the value storage variable as well as the changeValue function!

// To setup the inheritance, all we need is the is keyword in the contract declaration, which specifies which contract to inherit from.

// 📖 The body of the changeValue function is actually copied into the Derived functions bytecode, when inherited. Then we can deploy Derived as a standalone contract with all of its inherited functionality baked in.

// 🏁 Your Goal: Make SuperHeroes
// You'll notice that the SuperHeroes.sol file imports the Hero.sol read-only file. Your goal is to create two new contracts that inherit from the base Hero contract.

// Create two new contracts Mage and Warrior which inherit both the function and the state variable from the Hero contract.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

// TODO: create Mage/Warrior Heroes
contract Mage is Hero {}

contract Warrior is Hero {}

// Constructor Inheritance
// In the previous example, the Base contract had a state variable with an initial value and a function to modify it.

// What if the Base contract had an initial value that was set in a constructor?

// contract Base {
// 	uint public value;

//     constructor(uint _value) {
//         value = _value;
//     }
// }
// ☝️ Can we pass that initial value into the Base constructor when we're inheriting it? 🤔

// Sure can! 💪

// Same syntax as invoking a function:

// contract Derived is Base(10) {
//     // inherits everything from base contract!
// }
// ☝️ See how we passed 10 into the Base contract? This is provided as a constructor argument!

// 📖 It is possible to send multiple arguments to the constructor as well. This is also function syntax, comma-separated arguments within the parenthesis.

// 🏁 Your Goal: Specific Health 🌡️
// You'll notice that the Hero.sol file has changed on this stage! Now it has a constructor which takes a health argument.

// Let's modify our SuperHeroes so that Warrior has an initial health of 200 while the Mage has an initial health of 50.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

// TODO: create Mage/Warrior Heroes
contract Mage is Hero(50) {}

contract Warrior is Hero(200) {}

// Virtual & Override
// It's time to introduce two new function keywords: virtual and override.

// Sometimes we'll want to leave a function on a base contract open to 
// re-implementation by its derived class. That's where these two new keywords come in. 
// The virtual keyword allows us to specify a function on a contract that can be overridden 
// using the override keyword.

// contract Base {
// 	uint public value = 5;
// 	// this method can be overridden 
// 	function increaseValue() virtual external {
// 		value += 10;
// 	}
// }

// contract Derived is Base {
// 	// this method overrides the virtual method
// 	function increaseValue() override external {
// 		value *= 2;
// 	}
// }
// ☝️ In this case, both Derived and Base have different function bodies for increaseValue.

// The Derived contract will use its own implementation of increaseValue, 
// which overrides the virtual function implemented in Base.

// 🚧 The overriding function must have the same visibility as the virtual function. 
// If not the compiler will throw a TypeError: "Overriding function visibility differs". 
// Keep an eye out for that one!

// We can also specify abstract contracts where virtual functions do not require an implementation. 
// However, these functions must be implemented at some point by a derived contract.

// 🔍 Let's take a closer look at abstract functions in details.

// 🏁 Your Goal: SuperHero Attacks
// You'll notice the Hero.sol tab has changed once again! This time there's 
// three important things to notice:

// The Hero contract is an abstract contract. It has a virtual function called attack 
// which we'll need to override in both Warrior and Mage.
// An enum called AttackTypes has been added to the Hero contract to differentiate 
// between the different types of attacks our heroes can do.
// There's a contract called Enemy which has a method called takeAttack on it.
// Your job is to implement the attack function on the Warrior and Mage contracts:

// Add an override function called attack to both the Warrior and Mage contracts. 
// This function should take an Enemy parameter which will be an Enemy contract.
// Invoke takeAttack function on the Enemy contract and change the parameter based on the hero:
// For the Warrior, invoke the enemy's takeAttack with the Brawl attack type. ⚔️
// For the Mage, invoke the enemy's takeAttack with the Spell attack type. 🔮

// Abstract Contracts 📜
// Abstract Contracts can serve as templates for other contracts. They serve a similar purpose to interfaces. 
// Let's compare them:

// In an interface, none of the functions are implemented. 
// There are simply the function signatures with no function body.
// In an abstract contract, some functions may be implemented while others may not be. 
// You can pick and choose which functions to implement.
// 📖 Implicitly, all interface methods are virtual. 
// Abstract contracts must mark their methods as virtual if they wish to allow them to be overridden.

// Other than this, abstract contracts are just like regular contracts. 
// They can inherit from other contracts, they can have state variables and a constructor.

// Contracts can inherit interfaces. However, interfaces can only inherit other interfaces. 
// They cannot have state variables or a constructor.

// The Nitty Gritty 🤓
// When an abstract declares a virtual function without a function body, 
// that function must be implemented by some non-abstract contract inheriting from it.

// 📖 It may be confusing here mentioning the non-abstract contract. 
// Technically, an abstract contract can inherit from an abstract contract which can 
// inherit from another abstract contract… None of these abstract contracts can be deployed, 
// only the one that implements all of the functions.

// An abstract contract with unimplemented functions cannot be deployed. 
// They must be inherited by a function which implements those functions. 
// The derived contract which implements all the functions can be deployed.

// Let's take this code stage for example. For the Hero contract on the Hero.sol tab we don't know 
// what an attack from a plain hero would look like, so it is left unimplemented. However, 
// we want to ensure that every derived hero implements the attack function. 
// This way, we can guarantee that every Hero has an implemented attack function. 
// Each one will be special based on the derived contract's implementation.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

contract Warrior is Hero(200) { 
    function attack(Enemy enemy) public override {
        enemy.takeAttack(Hero.AttackTypes.Brawl);
    }
}

contract Mage is Hero(50) { 
    function attack(Enemy enemy) public override {
        enemy.takeAttack(Hero.AttackTypes.Spell);
    }
}

// Super Call
// In the last stage we wrote an override function for an unimplemented function on the base contract.

// In other cases, the base contract will have functionality in its virtual functions 
// that we want to share with our derived contracts. That's when it's time to use super.

// contract Base {
// 	uint public value = 10;

// 	function modify() virtual external {
// 		value *= 2;
// 	}
// }

// contract Derived is Base {
// 	function modify() virtual override external {
// 		value += 20;
//         super.modify(); // results in value = 60
//         // Base.modify() would also work!
// 	}
// }
// ☝️ You can see in our Derived contract we are modifying the value and then calling super.modify to 
// invoke the function on the base contract as well. 
// This will first perform value += 20 from the override function, 
// then perform value *= 2 from the super function, resulting in value=60.

// With arguments this works like any other function: we would pass through arguments to super.modify().

// 🏁 Your Goal: Add the Super!
// The attack function is now implemented by the Hero base contract. 
// It will take the enemy as an argument and decrement energy from our hero after every attack.

// Let's invoke this base contract function from within the attack 
// function for both (derived) hero contracts: Mage and Warrior.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

contract Warrior is Hero(200) { 
    function attack(Enemy enemy) public override {
        enemy.takeAttack(Hero.AttackTypes.Brawl);
        Hero.attack(enemy);
    }
}

contract Mage is Hero(50) { 
    function attack(Enemy enemy) public override {
        enemy.takeAttack(Hero.AttackTypes.Spell);
        super.attack(enemy);
    }
}


// Base Utility Contracts
// It is often quite useful for a base contract to provide utility functions and modifiers.

// Let's see an example:

// contract Depositable {
//     modifier requiresDeposit {
//         require(msg.value >= 1 ether);
//         _;
//     }
// }

// contract Escrow is Depositable {
//     address owner;
//     constructor() requiresDeposit {
//         owner = msg.sender;
//     }
// }
// ☝️ Here the Escrow contract requires a deposit of at least 1 ether in order to deploy. Otherwise the transaction will revert.

// This requirement comes from the base contract Depositable and is used through the inherited requiresDeposit modifier.

// 🏁 Your Goal: Only Owner
// On the Collectible.sol tab you'll see that Collectible contract inherits from the Ownable contract.

// Your goal is to fill out the Ownable base contract, which will be used by the Collectible contract!
// The owner should be defined in the Ownable base contract
// Ensure that markPrice can only be called by the owner (the deployer of the collectible)
// 💡 HINT: The markPrice function uses an onlyOwner modifier which is currently not implemented anywhere!

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    constructor() { owner = msg.sender; }
    address owner;
	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}


// Multiple Inheritance
// It's possible to inherit from multiple contracts.

// The derived contract will inherit state variables and functions from each base contract:

// contract Base1 {
//     uint a = 5;
// }
// contract Base2  {
//     uint b = 10;
// }
// contract Derived is Base1, Base2 {
//     // has access to both b and a!
// }
// ☝️ You can see we specify the contracts to inherit from in a comma-separated list. The Derived contract is inheriting from both Base1 and Base2.

// 🔍 When it comes to multiple inheritance, order matters! Let's take a closer look in details.

// 🏁 Your Goal: Collectible Transferable 💫
// The Collectible contract now also inherits from Transferable, a contract which has not been created yet!

// Your goal is to create a new contract Transferable that will allow the Collectible to transfer its ownership to another address.
// In the Transferable contract, create a function called transfer which takes an address for the new owner.
// Have this function transfer ownership from the current owner to the new owner passed in.
// Ensure that this function can only be called by the current owner.

// Multiple Inheritance Order
// When inheriting from contracts, the most base contract should be furthest left in the comma-separated list.

// For example:

// contract Base {

// }

// contract Middle is Base {

// }

// contract Top is Base, Middle {

// }
// ☝️ The important part here is that Top inherits from Base and Middle, in that order. Since Middle inherits from Base, this will not resolve if this order were reversed.

// In this code stage, we can see that Collectible is inheriting from both Ownable and Transferable in this order. Based on the order, Transferable can inherit from Ownable, but not vice-versa.

// In this code stage, it makes sense for Transferable to inherit from Ownable which is why these contracts were specified in this order.

// 🏆 You are more than welcome to test this out! If you try making Ownable inherit from Transferable, the compiler will complain with a pretty scary looking error: “Linearization of inheritance graph impossible”. You can see more details on this in the Solidity Docs.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {
    constructor() { owner = msg.sender; }
    address owner;
	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}

contract Transferable is Ownable {
	function transfer(address newOwner) external onlyOwner {
		owner = newOwner;
	}
}
