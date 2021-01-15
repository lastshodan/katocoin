// SPDX-License-Identifier: MIT

pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extradata)external;}

contract katoCoin{
    //public var of the token
    
    string  public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    
    //array with all balances
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    
    //this generates a public event on blkchain that will notify clnts
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    //this notifies clnts about the amnt burnt
    event Burn(address indexed from, uint256 value);
    
    //initializes contract with initial  supply tokens to the creator of the contract
    constructor (uint256 initialSupply, string tokenName, string tokenSymbol) public{
        totalSupply = initialSupply *10 ** uint256(decimals); //update total supply with dec amnt
        balanceOf[msg.sender] = totalSupply; //give crtor all initial tokens 
        name = tokenName;
        symbol = tokenSymbol;
    }//constructor
    
    //internal transfer only can be called by this contract
    function _transfer(address _from, address _to, uint _value) internal {
        //pvnt transsfer to 0x0 addr. use burn() instead
        require(_to != 0x0);
        //chk if the sender has enough
        require(balanceOf[_from] >= _value);
        //chk for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        //save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        //subtract from the sender
        balanceOf[_from] -= _value;
        //add the same to recipient 
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        
    }
}//katoCoin
