// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lottery {
    address[] public participants;
    address public owner;
    address public winner;
    mapping (address => bool) public hasParticipated;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value == 1, 'Deposit amount must be 1');
        require(!hasParticipated[msg.sender], 'You cannot participate in the lottery more than once');

        participants.push(msg.sender);
        hasParticipated[msg.sender] = true;
    }

    function pickWinner() public {
        require(msg.sender == owner, "Only owner can pick winner");
        require(participants.length > 0, "No players");

        uint index = random() % participants.length;
        winner = participants[index];

        (bool success, ) = payable(winner).call{value: address(this).balance}("");
        require(success, "Transfer failed");

        participants = new address[];
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, participants.length)));
    }
}