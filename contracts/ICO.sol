// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./NolanCoin.sol";
contract Ico {

    uint256 public constant ICO_EXCHANGE_RATE = 5;
    uint256 public constant CONTRIBUTION_LIMIT  = 100 ether;

    address public owner;
    NolanCoin public nolanCoin;

    bool public isPublic = false;

    mapping (address => bool) public allowList;

    

    constructor(address _owner, NolanCoin _nolanCoin) {
        owner = _owner;
        nolanCoin = _nolanCoin;
        
        
    }
    modifier onlyOwner {

        require(msg.sender == owner, "Not a Own");
        _;


    }

    function togglePublic(bool  toggle) external onlyOwner {

        isPublic = toggle;




    }
    error NotOwner(address owner);

    error  Unauthorized(string message);
    // error    success(string )


    function addToAllowList (address[] calldata addresses ,bool toggle) external  onlyOwner {
        for (uint256 i=0; i<addresses.length; i++) {

            allowList[addresses[i]] = toggle;
        }

    }

    



    function constribute()  external  payable {
        if(isPublic == false) {
             if(!allowList[msg.sender]) revert Unauthorized("Sorry you are not allowed to  contribute ");

        }

        if (msg.value != CONTRIBUTION_LIMIT) revert Unauthorized("fist You must contribute 90Matic ");
        
        nolanCoin.transfer(msg.sender, msg.value * ICO_EXCHANGE_RATE);


    }

    function withdraw(address to) external onlyOwner {


        (bool  success, ) = to.call{ value: address(this).balance }("");
        require(success,"withdraw failed");

    }
    
    
}   
