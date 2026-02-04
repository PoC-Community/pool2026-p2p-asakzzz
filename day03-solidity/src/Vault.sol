// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vault {
    string private _baseTokenURI;
    uint256 private _tokenIdCounter;

    uint256 totalShares;
    mapping(address => uint256) sharesOf;
    IERC20 immutable public asset;
    // need to correct that

    constructor(address _asset) {
        asset = IERC20(_asset);
    }

    function _convertToShares(uint256 assets) internal view returns (uint256) {
        uint256 totalAsset = asset.balanceOf(address(this));

        if (totalShares == 0) {
            return assets;
        } else {
            uint256 shares = (assets * totalShares) / totalAsset;
            return shares;
        }
    }

    function _convertToAssets(uint256 shares) internal view returns (uint256) {
        uint256 totalAssets = asset.balanceOf(address(this));

        if (totalShares == 0) {
            return 0;
        } else {
            uint256 assets = (shares * totalAssets) / totalShares;
            return assets;
        }
    }
}
