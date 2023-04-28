const hre = require("hardhat");

const main = async () => {
  // const ThrowbackNFT = await hre.ethers.getContractFactory("ThrowbackNFT");
  // const throwbackNFT = await ThrowbackNFT.deploy();

  // await throwbackNFT.deployed();

  // console.log("The Throwback NFT contract was deployed to: ", throwbackNFT.address);

  // await throwbackNFT.safeMint("0x484BF5CCdFE52C05387dFD4C1d10bA0adC94ed1a");
  // const uri = await throwbackNFT.tokenURI(0)
  // console.log("uri is:", uri);

  
  const FractionalizedNFT = await hre.ethers.getContractFactory("FractionalizedNFT");
  const fractionalizedNFT = await FractionalizedNFT.deploy();

  await fractionalizedNFT.deployed();

  console.log("The Fractionalized NFT contract was deployed to: ", fractionalizedNFT.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();