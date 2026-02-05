// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {PoolToken} from "../src/PoolToken.sol";


contract VaultTest is Test {
    VaultHelper vault;
    PoolToken token;

    // address alice = makeAddr("alice");
    uint256 constant INITIAL_SUPPLY = 1000 ether;

    function setUp() public {
        token = new PoolToken(INITIAL_SUPPLY);
        vault = new VaultHelper(address(token));
    }

    function test_Deployment() public view {
        assertEq(address(vault.asset()), address(token));
    }

    function test_InitialConversion() public view {
        uint256 amount = 100;
        uint256 shares  = vault._convertToSharesExt(amount);
        assertEq(shares, amount);
    }
}

contract VaultHelper is Vault {

    constructor(address _token) Vault(_token) {
    }

    function _convertToSharesExt(uint256 assets) public view returns (uint256) {
    return _convertToShares(assets);  
    }
    
    function _convertToSAssetsExt(uint256 shares) public view returns (uint256) {
    return _convertToAssets(shares);
    }
}
