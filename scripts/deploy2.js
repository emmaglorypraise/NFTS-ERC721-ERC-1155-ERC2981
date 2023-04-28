const hre = require("hardhat");

const main = async () => {
  const RetireCarbonCredits = await hre.ethers.getContractFactory("RetireCarbonCredits");
  const retireCarbonCredits = await RetireCarbonCredits.deploy();

  await retireCarbonCredits.deployed();

  console.log("The Retire Carbon Credits contract was deployed to: ", retireCarbonCredits.address);
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