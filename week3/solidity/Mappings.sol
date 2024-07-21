// Mappings
// Mappings are an important data type in Solidity. 
// With a mapping we can take values of one data type and map them to values of another data type.

// Let's consider an example. Say you wanted to track balances of a bunch of addresses:

// ADDRESS	BALANCE
// 0xc783df8a850f42e7F7e57013759C285caa701eB6	500
// 0xeAD9C93b79Ae7C1591b1FB5323BD777E86e150d4	100
// 0xE5904695748fe4A84b40b3fc79De2277660BD1D3	20
// Based on what we have learned so far you might be thinking of creating an array of structs:

// struct Account {
//     address addr;
//     uint balance;
// }

// Account[] accounts;
// ☝️ This works, certainly. When we need to find an address balance 
// we can iterate through the accounts to find the address we're looking for and retrieve the balance.

// However, there's a better way! We can use a mapping:

// mapping(address => uint) balances;
// ☝️ With a mapping each address is mapped to a unique place in memory where it stores the uint balance. 
// Looking up the balance is as simple as providing the address to the mapping: balances[addr].

// 💡 Under the hood, 
// the storage location is found by hashing the balances variable location with the address passed in. 
// It's a simple lookup! Much more efficient than iteration. 
// Generally it's better to try to use a mapping first and only use an array when you realize you need to iterate.

// Now that we see how mappings fit into the picture, let's learn how to build them! 🗺️

// Mapping
// Mappings allow you to store and retrieve elements quickly with a key. 
// The key points to a location in memory where the value is stored.

// The key can be any basic data type in Solidity. 
// It cannot be a reference data type like a struct or an array.

// The value, on the other hand, can be any Solidity type. 
// It can be a struct, an array or even another mapping!

// Let's see an example of a mapping:

// import "forge-std/console.sol";
// contract Contract {
//     // create a score state variable 
//     // maps an address (key) to a uint (value)
//     mapping(address => uint) public score;

//     function addPoint() external {
//         // we're using msg.sender as the key 
//         // to look up the score in storage
//         console.log(score[msg.sender]); // 0

//         // we can also update that location in storage
//         score[msg.sender]++;
//         console.log(score[msg.sender]); // 1
//     }
// }
// ☝️ The variable score takes an address and maps it to a uint. 
// Each address will be mapped to its own unique uint value that it can retrieve and modify.

// The addPoint function uses the msg.sender as the key to update a location in memory. 
// This location in memory for a value is initialized at zero. 
// We can add to it using the msg.sender as the key, as shown above.

// 💡 The score mapping is public which means that there will be a getter function created automatically. 
// We can make a request to an Ethereum node invoking this getter function with an address and get a uint back.

// 🏁 Your Goal: Members Mapping
// Create a public mapping called members which maps an address to a bool. 
// The bool will indicate whether or not the address is currently a member!
// Create an external function called addMember which takes an address and adds it as a member. 
// You can do this by storing true in the data location corresponding to the address in the members mapping.Mapping
// Mappings allow you to store and retrieve elements quickly with a key. 
// The key points to a location in memory where the value is stored.

// The key can be any basic data type in Solidity. 
// It cannot be a reference data type like a struct or an array.

// The value, on the other hand, can be any Solidity type. 
// It can be a struct, an array or even another mapping!

// Let's see an example of a mapping:

// import "forge-std/console.sol";
// contract Contract {
//     // create a score state variable 
//     // maps an address (key) to a uint (value)
//     mapping(address => uint) public score;

//     function addPoint() external {
//         // we're using msg.sender as the key 
//         // to look up the score in storage
//         console.log(score[msg.sender]); // 0

//         // we can also update that location in storage
//         score[msg.sender]++;
//         console.log(score[msg.sender]); // 1
//     }
// }
// ☝️ The variable score takes an address and maps it to a uint. 
// Each address will be mapped to its own unique uint value that it can retrieve and modify.

// The addPoint function uses the msg.sender as the key to update a location in memory. 
// This location in memory for a value is initialized at zero. 
// We can add to it using the msg.sender as the key, as shown above.

// 💡 The score mapping is public which means that there will be a getter function created automatically. 
// We can make a request to an Ethereum node invoking this getter function with an address and get a uint back.

// 🏁 Your Goal: Members Mapping
// Create a public mapping called members which maps an address to a bool. 
// The bool will indicate whether or not the address is currently a member!
// Create an external function called addMember which takes an address and adds it as a member. 
// You can do this by storing true in the data location corresponding to the address in the members mapping.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _address) external {
        members[_address] = true;
    }
    
}

// Mapping Retrieval
// Compared to arrays retrieving a value from a mapping is quite simple!

// Consider:

// mapping(address => bool) students;

// function isStudent(address addr) external view returns(bool) {
//     return students[addr];
// }
// Versus:

// address[] students;

// function isStudent(address addr) external view returns(bool) {
//     for(uint i = 0; i < students.length; i++) {
//         if(students[i] === addr) {
//             return true;
//         }
//     }
//     return false;
// }
// ☝️ To find if the student address is in the array we have to iterate over the array. 
// For the mapping we can simply plug in the address.

// ⛽ Choosing the right data structure is half the battle. 
// It can help keep the code clean and use less gas!

// 🔍 Curious how the value lookup for the mapping works under the hood? 
// Let's take a look in details.

// 🏁 Your Goal: Is Member
// Create an external, view function called isMember 
// which takes an address and returns a bool indicating whether or not the address is a member.

// The location of a value inside a mapping depends on two things:

// The variable position inside of the contract
// The mapping key to find the value
// The variable position is determined by where in the contract the mapping is defined:

// contract Contract {
//     mapping(address => uint) balances;
// }
// ☝️ In this example balances would be in storage slot 0 since it's the first variable. If there were a uint declared above it, it would be in storage slot 1.

// The mapping key will be the address for the balance we're trying to find. We can take the variable position and the mapping key and hash them together:

// keccak256(mappingKey + variablePosition);
// ☝️ This will result in a hash we can use to find the value stored by the mapping key. 
// If we needed to, we could use the sload method in assembly to do a 
// direct storage load at this location, retrieving the balance.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _address) external {
        members[_address] = true;
    }

    function isMember(address _address) external view returns(bool) {
        return members[_address];
    }
    
}

// Mapping Removal
// For arrays, removing elements can be an expensive operation, 
// especially if you don't want to leave any gaps!

// Let's say you had an array containing the unsigned integer values [1,2,3]. 
// Removing the first element 1 would mean you would have to shift the values 2 and 3 down one position each. 
// For a bigger array, this could mean many storage operations. Super expensive! 💰⛽

// 💡 In this case you could use a Linked List where you can "stitch" 
// the previous node to the next node instead of having to shift elements.

// For mappings, removal is quite simple. For example, in this students mapping:

// mapping(address => bool) students;

// function removeStudent(address addr) external {
//     students[addr] = false;
// }
// ☝️ Simple code! We provide the address to find the memory location and set it to false.

// 🏁 Your Goal: Remove Member
// Create an external function called removeMember that will take an address and 
// set its corresponding value in the members mapping to false.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _address) external {
        members[_address] = true;
    }

    function isMember(address _address) external view returns(bool) {
        return members[_address];
    }

    function removeMember(address _address) external {
        members[_address] = false;
    }
    
}

// Mapping to Struct
// Here's where mappings get interesting! We can map to many different types. Let's start with structs:

// contract Market {
//     // create the Collectible struct
//     struct Collectible {
//         address owner;
//         bool forSale;
//         uint price;
//     }

//     // map a uint ID to a Collectible struct
//     mapping(uint => Collectible) idToCollectible;

//     function purchase(uint _id) external payable {
//         // find the collectible by the id passed in
//         Collectible storage collectible = idToCollectible[_id];
//         // purchase the collectible
//         require(msg.value >= collectible.price);
//         collectible.owner = msg.sender;
//         collectible.forSale = false;
//     }
// }
// ☝️ We are able to lookup the collectible using the uint id passed into purchase. Then we have access to the struct to sell it to its new owner.

// 🏁 Your Goal: User Mapping Tokens
// Let's create a new token where every new user will receive 100 tokens!

// Create a public mapping called users that will map an address to a User struct.
// Create an external function called createUser. 
// This function should create a new user and associate it to the msg.sender address in the users mapping.
// The balance of the new user should be set to 100 and the isActive boolean should be set to true.
// 🔒 Contract Security
// Ensure that the createUser function is called with an address that is not associated with an active user. 
// Otherwise, revert the call.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

	mapping(address => User) public users;
	
	function createUser() external {
		require(!users[msg.sender].isActive);
		users[msg.sender] = User(100, true);
	}

}

// Types of Balances
// Broadly speaking, smart contracts deal with two type of value transfers:

// the native currency (ether), which is stored and transferred using the native EVM mechanisms, the value in the message call, and the balance on an address
// a storage value which can represent any kind of value on-chain, and is updated by modifying storage variables
// In the smart contract you are building, you are maintaining your own balances in the User struct that has no relation to ether. This means, to transfer balances from one user to another, you can just update the struct value!

// 🏁 Your Goal: Transfer Amount
// Create an external function called transfer which takes two parameters: an address for the recipient and a uint for the amount.
// In this function, transfer the amount specified from the balance of the msg.sender to the balance of the recipient address.
// 🔒 Contract Security
// Ensure that both addresses used in the transfer function have active users.
// Ensure that the msg.sender has enough in their balance to make the transfer without going into a negative balance.
// If either of these conditions aren't satisfied, revert the call.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

	mapping(address => User) public users;
	
	function createUser() external {
		require(!users[msg.sender].isActive);
		users[msg.sender] = User(100, true);
	}

	function transfer(address _address, uint _amount) external {
		require(users[msg.sender].isActive && users[_address].isActive);
		require(users[msg.sender].balance >= _amount);
		users[msg.sender].balance -= _amount;
		users[_address].balance += _amount;
	}

}

// Nested Mappings
// As shown in the previous stage, we can provide more complex types in our mapping values.

// Last stage we showed it with structs, now let's try it with other mappings!

// mapping(uint => mapping(address => bool)) voteToAddressChoice;

// function getVote(uint _id, address _addr) 
//     external
//     view 
//     returns(bool)
// {
//     return voteToAddressChoice[_id][_addr];
// } 
// ☝️ In this scenario each vote id points to a mapping of addresses to bool votes. This allows each address to register a different vote with each vote id.

// As a voter we might call a function with an id to register our choice:

// function registerVote(uint _id, bool _choice) external {
//     voteToAddressChoice[_id][msg.sender] = _choice;
// }
// Let's say there were 3 votes with the ids: 212, 72 and 409.

// We could make the following calls from external the contract:

// // for true for vote id 212
// votingContract.registerVote(212, true);
// // for false for vote id 72
// votingContract.registerVote(72, false);
// // for true for vote id 409
// votingContract.registerVote(409, true);
// ☝️ This would register a true for the ids 212 and 409 at our address. For 72 it would register false.

// 📖 Of course, the default value for a bool is false, so this second vote may be pointless unless we were to add in some other way to provide an non-existent vote.

// 🏁 Your Goal: Make Connections
// Create a public mapping called connections which will map an address to a mapping of an address to a ConnectionTypes enum value.
// In theconnectWith function, create a connection from the msg.sender to the other address.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	enum ConnectionTypes { 
		Unacquainted,
		Friend,
		Family
	}
	
	// TODO: create a public nested mapping `connections` 
	mapping(address => mapping(address => ConnectionTypes)) public connections;

	function connectWith(address other, ConnectionTypes connectionType) external {
        // TODO: make the connection from msg.sender => other => connectionType
		connections[msg.sender][other] = connectionType;
	}
}