// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";


contract TestSmartContract is Test {
    TestSmartContract sc;

    function setUp() public {
        sc = new TestSmartContract();
    }
    
    function test__convertToShares(uint256 assets) public {
        assertEq(assets, 0);
}

    function test_convertToAssets(uint256 assets) public {
        assertEq(test_convertToAssets(uint256 assets), 0);
}
    // function testDeployment() public {
    //     address mockToken = address(0x123);
    //     assertEq(address(TestSmartContract()), mockToken);
    // }
}



