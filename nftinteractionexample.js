// First, connect to the Ethereum network
const Web3 = require("web3");
const web3 = new Web3("https://mainnet.infura.io/v3/YOUR-PROJECT-ID");

// Next, load the contract ABI and address
const abi = YOUR_NFT_CONTRACT_ABI;
const address = YOUR_NFT_CONTRACT_ADDRESS;

// Then, create an instance of the NFT contract
const nftContract = new web3.eth.Contract(abi, address);

// Finally, interact with the contract to buy, sell, or trade NFTs
const tokenId = 123; // The ID of the NFT you want to buy, sell, or trade
const price = web3.utils.toWei("1", "ether"); // The price of the NFT in ether

// To buy an NFT:
await nftContract.methods
  .transferFrom(sellerAddress, buyerAddress, tokenId)
  .send({ from: buyerAddress, value: price });

// To sell an NFT:
await nftContract.methods
  .approve(yourMarketplaceAddress, tokenId)
  .send({ from: sellerAddress });
await yourMarketplaceContract.methods
  .buy(tokenId)
  .send({ from: buyerAddress, value: price });

// To trade an NFT:
await nftContract.methods
  .transferFrom(sellerAddress, buyerAddress, tokenId)
  .send({ from: buyerAddress });
await nftContract.methods
  .transferFrom(buyerAddress, sellerAddress, otherTokenId)
  .send({ from: sellerAddress });
