class Tree {
    constructor() {
        this.root = null;
    }

    addNode = (node) => {
        if (!this.root) {
            this.root = node;
            return;
        }

        let current = this.root;

        while (true) {
            if (node.data < current.data) {
                // Go left
                if (!current.left) {
                    current.left = node;
                    break;
                }
                current = current.left;
            } else {
                // Go right
                if (!current.right) {
                    current.right = node;
                    break;
                }
                current = current.right;
            }
        }
    }
}

module.exports = Tree;
