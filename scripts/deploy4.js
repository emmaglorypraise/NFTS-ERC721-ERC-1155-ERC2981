const hre = require("hardhat");

const main = async () => {
  
  // const GamifyOnChainNFT = await hre.ethers.getContractFactory("GamifyOnChainNFT");
  // const gamifyOnChainNFT = await GamifyOnChainNFT.deploy();

  // await gamifyOnChainNFT.deployed();

  // console.log("The GamifyOnChainNFT contract was deployed to: ", gamifyOnChainNFT.address);

  const contractAddress = "0xc84DBd9EAd44349b42fC02E3a2af7E6Bc343fC37";
  const myOnChainNFT = await hre.ethers.getContractAt("GamifyOnChainNFT", contractAddress);
  
  // const mintNFT = await myOnChainNFT.mint();

  // console.log("NFT hash:", mintNFT.hash);

  const playWithNFT = await myOnChainNFT.play(1);

  console.log("Played hash:", playWithNFT.hash);
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