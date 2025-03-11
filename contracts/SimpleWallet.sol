// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract SimpleWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    event Deposited(address indexed from, uint256 amount);
    event Withdrawn(address indexed from, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(address(this).balance >= amount, "Insufficient balance in the wallet");

        payable(owner).transfer(amount); // Переводим ETH владельцу
        emit Withdrawn(owner, amount); // Логируем снятие
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}