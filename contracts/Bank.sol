// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bank {
    address public owner;
    mapping(address => uint) public clients;
    mapping(address => bool) public isClient;

    constructor() {
        owner = msg.sender;
    }

    function openAccount() public {
        require(isClient[msg.sender] == false, "You already have a bank account.");
        isClient[msg.sender] = true;
        clients[msg.sender] = 0;
    }

    function closeAccount() public {
        require(isClient[msg.sender] == true, "You do not have a bank account.");
        isClient[msg.sender] = false;
        delete clients[msg.sender];
    }

    function deposit() public payable {
        require(isClient[msg.sender] == true, "You do not have a bank account.");
        require(msg.value > 0, "Deposit amount must be greater than 0.");

        clients[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public payable {
        require(isClient[msg.sender] == true, "You do not have a bank account.");
        require(clients[msg.sender] >= amount, "Insufficient funds in the balance.");

        payable(msg.sender).transfer(amount);
        clients[msg.sender] -= msg.value;
    }

    function getBalance() public view returns (uint256) {
        require(isClient[msg.sender] == true, "You are not a bank client.");
        return clients[msg.sender];
    }
}