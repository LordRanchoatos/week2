// Structs
// Structs provide Solidity Developers with a way to build custom data types. These data types can have multiple fields of data types we already have previously discussed.

// For example:

// struct Account {
//     uint balance;
//     bool isActive;
// }
// ☝️ This struct is composed of a uint and a bool. If this struct were defined outside of a contract, it can be shared across multiple contracts like so:

// struct Account {
//     uint balance
//     bool isActive;
// }

// contract A {
//     Account owner;
//     Account recipient;
// }

// contract B {
//     mapping (address => Account) accounts;
// }

// Structs
// With structs we can create custom types in Solidity that are essentially groupings of variables.

// For instance:

// enum Directions { Up, Down, Left, Right }

// struct Hero {
//     Directions facing;
//     uint health;
//     bool inAir;
// }
// ☝️ With this struct we can create new heroes which contain just these three properties.

// We can create a new Hero by invoking the struct with parenthesis:

// Hero hero = Hero(Directions.Up, 100, true);
// Then we can use the . operator to retrieve values from the hero:

// console.log(hero.facing == Directions.Up); // true
// console.log(hero.health); // 100
// console.log(hero.inAir); // true

// Alternate Struct Initialization
// Let's use the Hero example again! 🦸‍♂️🦸‍♀️

// enum Directions { Up, Down, Left, Right }

// struct Hero {
//     Directions facing;
//     uint health;
//     bool inAir;
// }
// As noted, we can create a Hero by providing the values in the same order they are provided in the struct:

// Hero hero = Hero(Directions.Up, 100, true);
// However, if the ordering of the struct variables ever changed, 
// we would need to update all of these initializations. 
// Also, it's not obvious from the initialization of the hero what those values even mean!

// Let's see the alternate approach:

// Hero hero = Hero({
//     facing: Directions.Up, 
//     health: 100, 
//     inAir: true
// });
// ☝️ Now the variable names help self-document the initiailization 
// and changing the order of the hero struct variables will not break it.

// Of course, if you changed the names of the struct variables, 
// that will only break this second initialization. So, you know, there's tradeoffs. 😅

// It's really a matter of code style. It may be smart to use the first approach with smaller structs:

// Person person = Person(name, age);
// ☝️ This might be pretty clear. Whereas:

// Transaction tx = Transaction(
//     msg.sender, 
//     address1, 
//     address2, 
//     msg.value, 
//     false
// );
// ☝️ Perhaps this would be a different story! Code readability should be a major factor here. 
// Your fellow developers (and your future self) will thank you for keeping your code clear! 👨‍💻👩‍💻

// Create a Vote
// Create a new struct called Vote that contains two properties: a Choices choice and an address voter.
// Then create a public storage variable called vote which is of the Vote type.
// Finally, in the createVote function create a new instance of Vote and store it in the storage variable vote. 
// Use the choice passed in as an argument and the msg.sender for the vote properties.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
		Choices choice;
		address voter;
	}

	Vote public vote;

	

	// TODO: create a vote struct and a public state variable

	function createVote(Choices choice) external {
		// TODO: create a new vote
		vote = Vote(choice, msg.sender);
	}
}