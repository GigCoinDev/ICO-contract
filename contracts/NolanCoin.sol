// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
import  "./ICO.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NolanCoin  is ERC20 {

    address public owner;
    address public ico;

    constructor() ERC20("Nolan Coin","Nl"){
        owner = msg.sender;
        ico = address(new Ico(owner, this));

        _mint(ico,100000*10**18);


    }

}

