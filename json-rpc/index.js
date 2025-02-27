// store api in an env file

const axios = require('axios');

// grab the API key from the .env
require('dotenv').config();
const url = `https://eth-mainnet.g.alchemy.com/v2/${process.env.API_KEY}`;

async function getBlockNumber() {
    const response = await axios.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_blockNumber", // <-- TODO: fill in the method name
    });

    // axios has a data prop which is the response from the server
    // TOOD: use this console log to locate the block number
    console.log(response.data); 

    // TODO: return the block number
    return response.data.result
}

module.exports = getBlockNumber;

require('dotenv').config();
const { API_KEY } = process.env;
const axios = require('axios');
// const url = `https://eth-mainnet.g.alchemy.com/v2/${API_KEY}`;

async function getBalance(address) {
    const response = await axios.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_getBalance", // <-- fill in the method
        params: [
            address,
            "latest"
        ],  // <-- fill in the params
    });

    // use this if you want to inspect the response data!
    console.log(response.data);

    // TODO: return the balance of the address
    return response.data.result
}

module.exports = getBalance;

async function getNonce(address) {
    const response = await axios.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_getTransactionCount", // <-- fill in the method
        params: [
            address,
            "latest"] // <-- fill in the params
    });
    
    // use this if you want to inspect the response data!
    console.log(response.data);

    // return the nonce for the address
    return response.data.result
}

module.exports = getNonce;

async function getTotalTransactions(blockNumber) {
    const response = await axios.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_getBlockByNumber",
        params: [
            blockNumber,
            true
        ], 
    });
    
    // use this if you want to inspect the response data!
    console.log(response.data);

    // return the total number of transactions in the block
    return response.data.result.transactions.length
}

module.exports = getTotalTransactions;

async function getTotalBalance(addresses) {
    const batch = addresses.map((addr, i) => ({
        jsonrpc: "2.0",
        id: i,
        method: "eth_getBalance",
        params: [
            addr,
        ]
    })) 

    const response = await axios.post(url, batch);
    
    // use this if you want to inspect the response data!
    console.log(response.data);
    
    // return the total balance of all the addresses 
    return response.data.reduce((a, c) => a + parseInt(c.result), 0)
}

module.exports = getTotalBalance;