// Fixed Arrays
// Fixed sized arrays have a set amount of values at compile-time.

// We can declare fixed size arrays in Solidity like so:

// uint[3] x = [1,2,3];
// address[1] y = [0xc783df8a850f42e7F7e57013759C285caa701eB6];
// bool[4] z = [true, true, false, false];

// These arrays have their size determined at compile-time. They cannot grow or shrink in size.
// If you store less elements in the array than the fixed size, the rest of the elements will be 
// the default value for the data type (i.e. false for bool and 0 for uint). 
// If you store more elements in the array than the fixed size, you'll get a compile-time TypeError!

// The above array declarations will work for state variables. Inside of a function,
// however, we will need to specify the data location of an array:

// uint[3] memory numbers = [1, 2, 3];
// ☝️ The data location for this array is memory. Memory is temporary, 
// it will only last as long as the transaction. The other data locations are calldata for 
// referring to message call arguments and storage for persistence.

// Data Location 📍
// There are three different locations for data in Solidity: calldata, memory and storage. Quite simply, 
// calldata is for referring to external argument data, memory is for temporary data, and storage is for 
// persistent data. Let's examine them more closely. 🔬

// calldata ☎️
// When we broadcast a transaction from an EOA to the EVM, we send data which includes an identifier for 
// the function we're targeting and the arguments we're sending.

// If we are referring to this message call data directly and we don't want to change it, we can use the 
// calldata location. This makes the argument is read-only, we cannot modify it.

// memory 🧠
// Memory is a temporary data location provided for us to keep our local variables in. 
// These variables will only exist in that scope for the length of the transaction.

// When we're working with arrays that should only exist for the length of the transaction, 
// and we'd like to modify them, we label them with the memory keyword. 
// We can read/write to this data location relatively cheaply when compared to storage. 
// If we use this keyword in the parameter list it will make a copy of the calldata array which can be modified.

// storage ⛓️
// Storage is the data that actually gets stored on the blockchain. This is where state variables are stored!

// For all the node operators in the network who store the state of the blockchain, this increases the amount of data they need to store. 
// For this reason storage operations are expensive.

// Value vs Reference
// Assigning an array will copy it in some cases and store a reference in other cases.

// Let's consider this example:

// import "forge-std/console.sol";
// contract Contract {
//     uint[3] numbers = [1,2,3];

//     function modify() external {
//         uint[3] memory memoryArray = numbers;
//         // will modifying memoryArray modify numbers?
//         memoryArray[0] = 4;
//         // nope! 
//         console.log(numbers[0]); // 1
//     }
// }
// ☝️ This will not modify the numbers. The values from numbers are copied into memoryArray at this assignment and they are otherwise unrelated.

// 📖 In fact, the compiler will warn that this can be labeled as a view since this function is not modifying an state.

// import "forge-std/console.sol";
// contract Contract {
//     uint[3] numbers = [1,2,3];

//     function modify() external {
//         uint[3] storage storageArray = numbers;
//         // will modifying storageArray modify numbers?
//         storageArray[0] = 4;
//         // yup! 
//         console.log(numbers[0]); // 4
//     }
// }
// ☝️ This will modify the numbers. In this case, storageArray contains a reference to numbers due to its storage location.

//  Find the Sum
// Create a pure, external function sum which takes a fixed size array of five unsigned integers.
// Find the sum of the unsigned integers and return it as a uint.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    function sum(uint[5] calldata x) external pure returns(uint total){
        for (uint i = 0; i < x.length; i++) {
            total += x[i];
        }
    }
}

//Note: js array method like reduce doesn't work for this purpose because array in solidity doesn't have access to this methiod.

// Dynamically Sized Arrays
// We can also create arrays in Solidity where the size is unknown at compile-time. These arrays are said to have dynamic size.

// For example:

// import "forge-std/console.sol";
// contract Contract {
//     function logFriends(address[] calldata friends) external view {
//         for(uint i = 0; i < friends.length; i++) {
//             console.log(friends[i]);
//         }
//     }
// }
// ☝️ Here we are able to log each address that is sent to the logFriends function.

// We use the length member available on the array to determine the number of elements 
// inside the dynamic sized array and then we use number indexes to retrieve the address.


// Sum Dynamic Array
// Create a pure, external function sum which takes a dynamic size array of unsigned integers.
// Find the sum of the unsigned integers and return it as a uint.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    function sum(uint[] calldata numbers) external returns(uint total) {
        for(uint i =0; i < numbers.length; i++){
            total += numbers[i];
        }

    }
    
}

// Storage Arrays
// With arrays in storage you can use the push member function to add a new element at the end.

// import "forge-std/console.sol";
// contract Contract {
// 	uint[] public numbers;

//     constructor() {
// 		numbers.push(3);
// 		console.log(numbers.length); // 1
// 		numbers.push(4);
// 		console.log(numbers.length); // 2
// 		console.log(numbers[0]); // 3
// 		console.log(numbers[1]); // 4
//     }
// }
// ☝️ As you might expect the length member adjusts when new elements are pushed onto the end of the array.

// 🏁 Your Goal: Filter Even Numbers
// Create a public, dynamic sized array of unsigned integers as a state variable called evenNumbers.
// Create an external function called filterEven which takes an dynamic size array of unsigned integers as its only argument. 
// Find all of the even numbers in this array and push them into the evenNumbers storage array.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    uint[] public evenNumbers;

    function filterEven(uint[] calldata numbers) external {
        for(uint i = 0; i < numbers.length; i++){
            if(numbers[i]%2 == 0){
                evenNumbers.push(numbers[i]);
            }
        }
    }
    
}

// memory arrays
// Unlike storage arrays, memory arrays do not have a push member function.

// Memory arrays can have a dynamic size if the size is provided during initialization.

// For example:

// import "forge-std/console.sol";
// contract Contract {
// 	uint x = 5;

// 	function createArray() view external {
// 		address[] memory addresses = new address[](x);
// 		console.log( addresses.length ); // 5
// 	}
// }

// ☝️ The size is dynamically provided by the variable x. We could potentially change this variable and it would create an array of
// addresses of that size. Notice the use of the new operator here during initialization!

// After initialization, memory arrays cannot be resized. This means even in the example above, 
// once the addresses array is initialized at size 5, it will stay that length for the entirety of the transaction.

// Filter Numbers over 5 in Memory
// Let's say we wanted to filter numbers over 5 in memory:

contract Contract {
	function filter(uint[] calldata numbers) 
        external 
        pure 
        returns(uint[] memory) 
    {
        // find the number of elements over 5
		uint elements;
		for(uint i = 0; i < numbers.length; i++) {
			if(numbers[i] > 5) {
                elements++;
            }
		}

        // create a new array with this size
		uint[] memory filtered = new uint[](elements);
        // keep an index for the positions we have filled
		uint filledIndex = 0;
		for(uint i = 0; i < numbers.length; i++) {
			if(numbers[i] > 5) {
				filtered[filledIndex] = numbers[i];
				filledIndex++;
			}
		}
		return filtered;
	}
}
// ☝️ This is quite a bit tougher to do without the push member function.
// We need to first find the number of elements over 5 in the passed-in array so that we can initialize the return array at that size.

// Now you won't take dynamically resized arrays for granted! 😅

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    function filterEven(uint[] calldata numbers) external pure returns(uint[] memory){
    uint elements;
    for (uint i = 0; i < numbers.length; i++){
            if (numbers[i]%2 == 0){
                elements++;
            }
        }

        uint[] memory evenNumbers = new uint[](elements);
        uint currentIndex = 0;
        for (uint i = 0; i < numbers.length; i++){
            if (numbers[i]%2 == 0){
                evenNumbers[currentIndex] = numbers[i];
                currentIndex++;
            }
        }
        return evenNumbers;
    }
}


// Stack Club
// This StackClub contract will have many members like a club or an organization would. 
// We'll track these members by keeping a list of addresses.

// Members will be added by pushing their address to the top of the list. 
// Members will be removed by popping the most recent one off of the list. A Last-In-First-Out structure, just like a stack!

// 🏁 Your Goal: Add Members 👨👩
// Create a dynamic sized array of addresses called members
// Create an external function addMember which has a single parameter: an address for a new member. Add this address to the members array.
// Create a public view function isMember that takes an address and returns a bool indicating whether the address is a member or not.

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
	address[] members; 

	function isMember(address member) external view returns(bool) {
		for(uint i = 0; i < members.length; i++) {
			if(members[i] == member) {
				return true;
			}
		}
		return false;
	}

	function addMember(address member) external {
		members.push(member);
	}
}

// Pop
// Storage arrays also have access the pop member variable:

import "forge-std/console.sol";
contract Contract {
	uint[] public numbers;

    constructor() {
		numbers.push(3);
		numbers.push(4);
		console.log(numbers.length); // 2
		numbers.pop();
		console.log(numbers.length); // 1
        console.log(numbers[0]); // 3
    }
// }
// ☝️ As you can see, pop will take the top element off the storage array.

// 🏁 Your Goal: Remove Members
// Create a constructor which will add the deployer address as the first member of the stack club.
// Create a removeLastMember function which will remove the last member added to the club.
// 🔒 Function Security
// Ensure that the removeLastMember function can only be called by an existing member
// Ensure that addMember can only be called by an existing member

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
	address[] members;

	constructor() {
		members.push(msg.sender);
	}

	function isMember(address member) public view returns(bool) {
		for(uint i = 0; i < members.length; i++) {
			if(members[i] == member) {
				return true;
			}
		}
		return false;
	}

	function removeLastMember() external {
		require(isMember(msg.sender));
		members.pop();
	}

	function addMember(address member) external {
		require(isMember(msg.sender));
		members.push(member);
	}
}
