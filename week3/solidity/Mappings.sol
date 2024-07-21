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