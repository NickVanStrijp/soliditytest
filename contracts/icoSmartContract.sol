pragma solidity ^0.4.0;

contract icoSmartContract{
    //Creating a public address variable for the buyer of the ICO 
    address public buyer;
    
    //Creating a structure for the ICO details to be stored
    
    //ICO Name
    string icoName;
    //Creating a public variable for the address of the ICO
    address icoAddress;
    // Unix time variable for the ICO start time
    uint icoStartTime;
    // Starting block number for the ICO
    uint icoStartBlock;
    
    //For each address, the contract will store the amount of eth associated
    mapping (address => uint) public balances;
    
    //Initializing the smart contract setting the message sender as the buyer
    //with the permissions that come with it (setting icoInformation and balance)
    function icoSmartContract(uint amount) {
        buyer = msg.sender;
        //Adding the amount of ether sent to the contract to the buyer's balance
        balances[buyer] += amount;
        
        //Initialize an array to store the ICO info
        
    }
    //Allows the buyer to change the ICO name
    function changeIcoName(string name){
        require(buyer == msg.sender);
        icoName = name;
    }
    
    //Allows the buyer to change the ICO address
    function changeIcoAddress(address to){
        require(buyer == msg.sender);
        icoAddress = to;
    }
    
    //Allows the buyer to change the ICO address
    function changeStartTime(uint16 year,
        uint8 month,
        uint8 day,
        uint8 hour,
        uint8 minute,
        uint8 second){
        require(buyer == msg.sender);
        
        
        
    }
    
    function dateTimetoUnix(uint16 year,
        uint8 month,
        uint8 day,
        uint8 hour,
        uint8 minute,
        uint8 second){
        
        
    }
}
