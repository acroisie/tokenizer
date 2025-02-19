// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Acroisie42 is ERC20, Ownable {
    constructor() ERC20("Acroisie42", "ACR42") Ownable(msg.sender) {
        uint256 startAmount = 8000 * 10 ** decimals();
        _mint(address(this), startAmount);
    }

    function burnTokens(address account, uint256 amount) external {
        _burn(account, amount);
    }

    function mintTokensToTreasury(uint256 amount) external onlyOwner {
        _mint(address(this), amount);
    }

    function myBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function transferFromTreasury(address to, uint256 amount) external onlyOwner {
        require(balanceOf(address(this)) >= amount, "Insufficient funds in treasury.");
        _transfer(address(this), to, amount);
    }

    function treasuryBalance() external view returns (uint256) {
        return balanceOf(address(this));
    }
}
