const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contract with the account:", deployer.address);

  const freelancerAddress = "0x000000000000000000000000000000000000dead"; // Replace with actual freelancer address
  const amountToLock = hre.ethers.utils.parseEther("0.5"); // Change as required

  const Escrow = await hre.ethers.getContractFactory("FreelanceEscrow");
  const escrow = await Escrow.deploy(freelancerAddress, { value: amountToLock });

  await escrow.deployed();

  console.log("FreelanceEscrow deployed to:", escrow.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
