import { ethers } from "hardhat";

export const deploy = async (contractName: string, args: Array<any>, accountIndex?: number): Promise<ethers.Contract> => {
    console.log(`Deploying ${contractName}...`);

    const ContractFactory = await ethers.getContractFactory(contractName);
    const contract = await ContractFactory.deploy(...args);
    await contract.deployed();

    console.log(`${contractName} deployed to: ${contract.address}`);
    return contract;
};

async function main() {
    const contractName = "Bank";
    const args = [];

    const deployedContract = await deploy(contractName, args);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });