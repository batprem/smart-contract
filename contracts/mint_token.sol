pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MintableToken is Ownable, ERC20 {
    constructor() public ERC20("Gold", "GLD") { }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }
    function airdrop(address source, address destination) public onlyOwner{
        
    }
}