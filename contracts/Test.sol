// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    int num_1 = -100;
    uint256 num_2 = 100;
    address addr;
    bool flag;
    bytes32 bts = '001';

    uint[] arr_1 = [1, 2, 3];
    uint[5] arr_2 = [1, 2, 3, 4, 5];
    struct MyStruct {uint val; address addr;}
    mapping (address => uint) mapp_str;

    constructor () {
        addr = msg.sender;
    }

    function setVal1(uint _val) external {
        num_2 = _val;
    }

    function setVal2(int _val) internal {
        num_1 = _val;
    }

    function setVal3(uint _val) public  {
        num_2 = _val;
    }

    function setVal4(uint _val) private  {
        num_2 = _val;
    }
    
    function setVal5(uint _val) public pure {
        uint[] memory arr = new uint[](5);
    }

    function setVal6(uint _val) public view {
        uint[] memory arr = new uint[](5);
    }

    modifier onlyOwner() {
        require(msg.sender == addr, "Not allowed");
        _;
    }

    function setVal7(uint _val) public onlyOwner {
        num_2 = _val;
    }

    function setVal8(uint _val) public onlyOwner returns (bool, uint) {
        return (flag = true, _val);
    }

    function setVal9(uint _val) public payable {
        mapp_str[msg.sender] = msg.value;
    }
}