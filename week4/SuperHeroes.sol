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