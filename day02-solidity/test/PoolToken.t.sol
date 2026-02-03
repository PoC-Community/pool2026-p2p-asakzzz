function testInitialSupply() public {
    assertEq(token.totalSupply(), INITIAL_SUPPLY);
    assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
}

function testOnlyOwnerCanMint() public {
    vm.prank(user);
    vm.expectRevert();
    token.mint(user, 1000 ether);
}