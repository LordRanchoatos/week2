class Transaction {
  constructor(inputUTXOs, outputUTXOs) {
    this.inputUTXOs = inputUTXOs;
    this.outputUTXOs = outputUTXOs;
  }
  execute() {
    const anySpent = this.inputUTXOs.some((x) => x.spent);
    if (anySpent) {
      throw new Error('Cannot include a spent UTXO');
    }
    let sumInput = 0;
    let sumOutput = 0;
    for (let i = 0; i < this.inputUTXOs.length; i++) {
      sumInput += this.inputUTXOs[i].amount;
    }
    for (let i = 0; i < this.outputUTXOs.length; i++) {
      sumOutput += this.outputUTXOs[i].amount;
    }
    console.log(sumInput);
    console.log(sumOutput);

    if (sumInput < sumOutput) {
      throw new Error('Your balance is low');
    }
  }
}

module.exports = Transaction;


// solution 2  
class Transaction {
    constructor(inputUTXOs, outputUTXOs) {
        this.inputUTXOs = inputUTXOs;
        this.outputUTXOs = outputUTXOs;
    }
    execute() {
        const anySpent = this.inputUTXOs.some((x) => x.spent);
        if (anySpent) {
            throw new Error("Cannot include a spent UTXO");
        }

        const inputAmount = this.inputUTXOs.reduce((p, c) => {
            return p + c.amount;
        }, 0);
        const outputAmount = this.outputUTXOs.reduce((p, c) => {
            return p + c.amount;
        }, 0);
        if (inputAmount < outputAmount) {
            throw new Error("Not enough here");
        }

        this.inputUTXOs.forEach((utxo) => {
            utxo.spend();
        });
    }
}

module.exports = Transaction;