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

const TrieNode = require('./TrieNode');

class Trie {
    constructor() {
        this.root = new TrieNode(null);
    }
    insert(word) {
        let node = this.root;

        for (let i = 0; i < word.length; i++) {
            node.children[word[i]] = new TrieNode(word[i]);
            node = node.children[word[i]];

            if (i == word.length - 1) {
                node.isWord = true;
            }
        }
    }
}

module.exports = Trie;

//insert branching 
class TrieNode {
    constructor(key) {
        this.key = key;
        this.children = {};
        this.isWord = false;
    }
}

module.exports = TrieNode;

const TrieNode = require('./TrieNode');

class Trie {
    constructor() {
        this.root = new TrieNode(null);
    }
    insert(word) {
        let node = this.root;

        for (let i = 0; i < word.length; i++) {
            if (!node.children[word[i]]) {
                node.children[word[i]] = new TrieNode(word[i]);
            }

            node = node.children[word[i]];

            if (i == word.length - 1) {
                node.isWord = true;
            }
        }
    }
}

module.exports = Trie;

//contains : does it contain the word?

const TrieNode = require('./TrieNode');

class Trie {
    constructor() {
        this.root = new TrieNode(null);
    }
    insert(word) {
        let node = this.root;

        for (let i = 0; i < word.length; i++) {
            if (!node.children[word[i]]) {
                node.children[word[i]] = new TrieNode(word[i]);
            }

            node = node.children[word[i]];

            if (i == word.length - 1) {
                node.isWord = true;
            }
        }
    }
    contains(word) {
        let node = this.root;

        for (let i = 0; i < word.length; i++) {
            if (node.children[word[i]]) {
                node = node.children[word[i]];
            } else {
                return false;
            }
        }

        return node.isWord;
    }
}

module.exports = Trie;

// week2 assignment done