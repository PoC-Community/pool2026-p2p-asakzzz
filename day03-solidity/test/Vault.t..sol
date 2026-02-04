// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract VaultTest is Test {
    VaultHelper vault;

    function setUp() public {
        vault = new VaultHelper(address(0x123));
    }

    function test_Deployment() public view {
        assertEq(address(vault.asset()), address(0x123));
    }

    function test_InitialConversion() public view {
        uint256 amount = 100;
        uint256 shares  = vault._convertToSharesExt(amount);
        assertEq(shares, amount);
    }
}

contract VaultHelper is Vault {

    constructor(address _token) Vault(_token) {}

    function _convertToSharesExt(uint256 assets) public view returns (uint256) {
    return _convertToShares(assets);  
    }
    
    function _convertToSAssetsExt(uint256 shares) public view returns (uint256) {
    return _convertToAssets(shares);
    }
}
