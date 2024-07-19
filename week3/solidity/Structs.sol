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

// Returning Structs
// When you're returning structs or other reference types like arrays, 
// you have to clarify where the data is coming from using data location keywords: storage, memory, or calldata.

// However, for external and public methods, you can't use the storage keyword for the return parameter. 
// The storage keyword would provide a direct reference to a location within the contract's own persistent storage, which cannot be accessed outside of the contract. Use memory or calldata instead to return a copy of the data.

// Let's take a look at an example of a struct being returned in memory:

// struct Hero { uint health }

// function postHero(Hero hero) external {
//     // take a Hero type as an external argument
//     console.log(hero.health); // 100
// }

// function getHero() external view returns (Hero memory) {
//     // return Hero in an external function
//     return Hero(100);
// }
// 🏁 Your Goal: Return Memory Vote
// Create an external, view function called createVote which takes Choices value as a parameter 
// and returns an instance of type Vote.
// This function should use the Choices value and the msg.sender as the values to create the vote.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: make a new createVote function
	function createVote(Choices choices) external view returns(Vote memory){
		return Vote(choices, msg.sender);
	}
}

// Struct Arrays
// We can create an array of struct types, just like we would with any other data type!

// // a dynamic size list of uints
// uint[] numbers;

// struct Account {
//     uint id;
//     uint balance;
// }
// // a dynamic size list of Accounts
// Account[] accounts;
// We can also push and retrieve accounts like any other storage array:

// accounts.push(Account(0, 100));

// console.log(accounts[0].id); // 0
// console.log(accounts[0].balance); // 100
// ☝️ Of course, push only works on storage arrays, as we learned in the lesson on arrays!

// 🏁 Your Goal: Vote Array
// Create a public storage array of the Vote struct called votes.
// In the createVote function use the choice parameter and the msg.sender 
// to create a new vote and push it onto the array of votes.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: create a public state variable: an array of votes
	Vote[] public votes;

	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
		votes.push(Vote(choice, msg.sender));
	}
}

// Accessing Struct Properties
// It's time to access some of the struct properties we stored! 
// You can do this using the . operator. Let's see a few examples:

// import "forge-std/console.sol";
// contract X {
//   struct Human {
//     string name;
//     uint age;
//   }
//   Human human = Human("Dan", 33);
//   Human[] humans; 

//   constructor() {
//     humans.push(human);

//     // read from this struct directly 
//     console.log(human.name); // Dan

//     // read from the array of humans
//     console.log(humans[0].age); // 33
//   }
// }


// 🏁 Your Goal: Find Vote
// Create an external, view function hasVoted which takes an address and returns a bool 
// indicating if the address has cast a vote or not.
// Create an external, view function findChoice which takes an address and returns a 
// Choices value indicating the choice on the vote cast by the address. 
// For this function there is no need to worry about the case where a vote was not cast.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}

	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes; 

	function createVote(Choices choice) external {
		votes.push(Vote(choice, msg.sender));
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}
}


// 🏁 Your Goal: Vote Once
// Each address should only be allowed to call createVote once.
// If they try again, the call should be reverted. 🔒

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}

	Vote none = Vote(Choices(0), address(0));

	Vote[] public votes; 

	function createVote(Choices choice) external {
		require(!hasVoted(msg.sender));
		votes.push(Vote(choice, msg.sender));
	}

	function findVote(address voter) internal view returns(Vote storage) {
		for(uint i = 0; i < votes.length; i++) {
			if(votes[i].voter == voter) {
				return votes[i];
			}
		}
		return none;
	}

	function hasVoted(address voter) public view returns(bool) {
		return findVote(voter).voter == voter;
	}

	function findChoice(address voter) external view returns(Choices) {
		return findVote(voter).choice;
	}
}