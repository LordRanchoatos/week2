class Tree {
  constructor() {
    this.root = null;
  }

  hasNode(data) {
    return this.searchRoot(this.root, data);
  }

  searchRoot(root, data) {
    if (!root) {
      return false;
    }
    if (root.data === data) {
      return true;
    }
    if (root.data > data) {
      return this.searchRoot(root.left, data);
    }
    if (root.data < data) {
      return this.searchRoot(root.right, data);
    }
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
  };
}

// module.exports = Tree;
module.exports = Tree;
