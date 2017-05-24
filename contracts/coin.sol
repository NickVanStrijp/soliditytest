pragma solidity ^0.4.0;

contract Coin {
    address public minter;
    mapping (address => uint) balance;
    
    event sent(address to, address from, uint amount);
    
    function Coin() {
        minter = msg.sender;
    }
    
    function mint(address receiver, uint amount) {
        if (msg.sender != minter) return;
        balance[receiver] += amount;
    }
    
    function send(address receiver, uint amount) {
        if (balance[msg.sender] < amount) return;
        balance[msg.sender] -= amount;
        balance[receiver] += amount; 
        
        sent(receiver, msg.sender, amount);
    }
}