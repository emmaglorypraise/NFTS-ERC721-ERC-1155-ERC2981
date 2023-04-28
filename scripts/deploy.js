const hre = require("hardhat");

const main = async () => {
  const MyToken = await hre.ethers.getContractFactory("MyToken");
  const Token = await MyToken.deploy();

  await Token.deployed();

  console.log("The MyToken contract was deployed to: ", Token.address);
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