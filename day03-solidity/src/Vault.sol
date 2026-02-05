// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Vault is Ownable, ReentrancyGuard {
    // string private _baseTokenURI;
    // uint256 private _tokenIdCounter;
    uint256 totalShares;
    using SafeERC20 for IERC20;

    mapping(address => uint256) sharesOf;
    IERC20 public immutable asset;

    constructor(address _asset) Ownable(msg.sender) {
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

    function deposit(
        uint256 assets
    ) external nonReentrant returns (uint256 shares) {
        if (assets > 0) {
            shares = _convertToShares(assets);
        } else {
            return 0;
        }

        if (shares > 0) {
            sharesOf[msg.sender] += shares;
            totalShares += shares;
        } else {
            return 0;
        }

        asset.safeTransferFrom(msg.sender, address(this), assets);
    }

    function withdraw(uint256 shares) public nonReentrant returns (uint256 assets) {
        if (assets > 0) {
            shares = _convertToAssets(shares);
        } else {
            return 0;
        }

        if (shares > 0) {
            sharesOf[msg.sender] -= shares;
            totalShares -= shares;
        } else {
            return 0;
        }

        asset.safeTransfer(msg.sender, assets);

        return assets;
    }
}
