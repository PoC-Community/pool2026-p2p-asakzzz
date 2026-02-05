// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {PoolToken} from "../src/PoolToken.sol";


contract VaultTest is Test {
    VaultHelper vault;
    PoolToken token;

    address alice = makeAddr("alice");
    address thomas = makeAddr("thomas");
    uint256 constant INITIAL_SUPPLY = 1000 ether;

    function setUp() public {
        token = new PoolToken(INITIAL_SUPPLY);
        vault = new VaultHelper(address(token));
        token.mint(alice, 500 ether);
    }

    function test_Deployment() public view {
        assertEq(address(vault.asset()), address(token));
    }

    function test_InitialConversion() public view {
        uint256 amount = 100;
        uint256 shares  = vault._convertToSharesExt(amount);
        assertEq(shares, amount);
    }

    function test_DepositFlow() public {
        uint256 depositAmount = 100 ether;
        
        vm.startPrank(alice);
        
        token.approve(address(vault), depositAmount);
        
        uint256 shares = vault.deposit(depositAmount);
        
        assertEq(shares, depositAmount);
        assertEq(token.balanceOf(address(vault)), depositAmount);
        
        vm.stopPrank();
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
