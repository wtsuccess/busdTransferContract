import { ethers } from "hardhat";
import { BUSDHandler, BUSDHandler__factory,} from "../typechain-types";

async function main() {
  const BUSDHandler: BUSDHandler__factory = await ethers.getContractFactory("BUSDHandler");
  const busdHandler: BUSDHandler = await BUSDHandler.deploy("0xe9e7cea3dedca5984780bafc599bd69add087d56 ");
  await busdHandler.deployed();
  console.log("Contract deployed to address:", busdHandler.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
