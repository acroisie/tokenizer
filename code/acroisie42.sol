// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


contract Acroisie42 is ERC20, Ownable {
    constructor() ERC20("acroisie42", "ACR42") {
        uint256 startAmount = 8 * 10 ** decimals();
        _mint(address(this), startAmount);
    }

    function burn(address account, uint256 burnAmount) external  {
        _burn(account, burnAmount);
    }

    function mint(uint256 mintAmount) external  {
        _mint(address(this), mintAmount);
    }

    function getBalance() external view returns(uint256) {
        return  balanceOf(address(this));
    }
}