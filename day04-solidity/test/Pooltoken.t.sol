// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";


contract PooltokenTest is Test {

    function setUp() public {
    }

    constructor(address _asset) Ownable(msg.sender) {
        asset = IERC20(_asset);
    }


    function testInitialVotingPowerIsZero(uint256 asset) returns (uint256) {
        totalAssets = asset.balanceOf(address(this));
        if (totalAssets != 0) {
            assertEq(getVotes() , 0);
        }
    }

    function testDelegateToSelf()  returns (uint256) {
        if (delegate(self)) {
            getVotes(address) = asset.balanceOf(address(this)); 
        }
    }
}