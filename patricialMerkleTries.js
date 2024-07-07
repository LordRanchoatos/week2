// Your Goal: Constructors
// Implement the constructor function for both the Trie and TrieNode class.

// For each TrieNode instance, add three properties:

// key - This will be passed to the node, it is the letter stored as a string
// children - This will be an object, containing the children elements, by default set it to an empty object
// isWord - This will be a boolean, whether or not the node finishes a word, set it to false by default.
// For each Trie instance, add a single property:

// root - This will be an instance of TrieNode that contains a null key. The null key will indicate that this is the top parent in the list.
// ✅ Be sure to store these properties on this so they are accessible for every instance of the class.

const TrieNode = require('./TrieNode');

class Trie {
    constructor() {
        this.root = new TrieNode(null)
    }
}

module.exports = Trie;

class TrieNode {
    constructor(key) {
        this.key = key,
        this.children = {},
        this.isWord = false
    }
}

module.exports = TrieNode;