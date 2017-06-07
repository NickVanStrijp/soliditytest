pragma solidity ^0.4.0;

contract SchedulerInterface {
    uint temporalUnit = 1; 
    
    function scheduleTransaction(address toAddress,
                                 bytes callData,
                                 uint[4] uintArgs) doReset public returns (address);
}

contract IcoSmartContract{
    //Constants for date function calculations 
    uint constant DAY_IN_SECONDS = 86400;
    uint constant YEAR_IN_SECONDS = 31536000;
    uint constant LEAP_YEAR_IN_SECONDS = 31622400;
    uint constant HOUR_IN_SECONDS = 3600;
    uint constant MINUTE_IN_SECONDS = 60;
    uint16 constant ORIGIN_YEAR = 1970;
    
    //Instantiating a way to interact with with Ethereum Alarm Clock service through a new contract
    SchedulerInterface constant scheduler = SchedulerInterface(0x6c8f2a135f6ed072de4503bd7c4999a1a17f824b);

    //Creating a public address variable for the buyer of the ICO 
    address public buyer;
    //ICO Name
    string icoName;
    //Creating a public variable for the address of the ICO
    address icoAddress;
    // Unix time variable for the ICO start time
    uint icoStartTime;
    // Starting block number for the ICO
    uint icoStartBlock;
    
    //
    function scheduleIco() {
        
        uint[3] memory uintArgs = [
            200000,      // the amount of gas that will be sent with the txn.
            0,           // the amount of ether (in wei) that will be sent with the txn
            lockedUntil, // the first block number on which the transaction can be executed.
        ];
        
        // Schedule a call to the `callback` function
        Scheduler.value(2 ether).scheduleCall(
            address(this),               // the address that should be called.
            bytes4(sha3("callback()")),  // 4-byte abi signature of callback fn
            block.number + 480,          // the block number to execute the call
        );
    }
    
    //For each address, the contract will store the amount of eth associated
    mapping (address => uint) public balances;
    
    //Initializing the smart contract setting the message sender as the buyer
    //with the permissions that come with it (setting icoInformation and balance)
    function IcoSmartContract(uint amount) {
        buyer = msg.sender;
        //Adding the amount of ether sent to the contract to the buyer's balance
        balances[buyer] += amount;
        
        
        
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
        
        uint newtimestamp = toTimestamp(year, month, day, hour, minute, second);
        
        //+5 seconds room for lag or error 
        icoStartTime = newtimestamp + 5 seconds;
    }

    //Allows the buyer to change the ICO start block. 
    function changeStartBlock(uint newBlock){
        require(buyer == msg.sender);
        icoStartBlock = newBlock;
    }
    
    function isLeapYear(uint16 year) constant returns (bool) {
                if (year % 4 != 0) {
                        return false;
                }
                if (year % 100 != 0) {
                        return true;
                }
                if (year % 400 != 0) {
                        return false;
                }
                return true;
    }

    function toTimestamp(uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) 
        constant returns (uint timestamp) {
                    uint16 i;
    
                    // Year
                    for (i = ORIGIN_YEAR; i < year; i++) {
                            if (isLeapYear(i)) {
                                    timestamp += LEAP_YEAR_IN_SECONDS;
                            }
                            else {
                                    timestamp += YEAR_IN_SECONDS;
                            }
                    }
    
                    // Month
                    uint8[12] memory monthDayCounts;
                    monthDayCounts[0] = 31;
                    if (isLeapYear(year)) {
                            monthDayCounts[1] = 29;
                    }
                    else {
                            monthDayCounts[1] = 28;
                    }
                    monthDayCounts[2] = 31;
                    monthDayCounts[3] = 30;
                    monthDayCounts[4] = 31;
                    monthDayCounts[5] = 30;
                    monthDayCounts[6] = 31;
                    monthDayCounts[7] = 31;
                    monthDayCounts[8] = 30;
                    monthDayCounts[9] = 31;
                    monthDayCounts[10] = 30;
                    monthDayCounts[11] = 31;
    
                    for (i = 1; i < month; i++) {
                            timestamp += DAY_IN_SECONDS * monthDayCounts[i - 1];
                    }
    
                    // Day
                    timestamp += DAY_IN_SECONDS * (day - 1);
    
                    // Hour
                    timestamp += HOUR_IN_SECONDS * (hour);
    
                    // Minute
                    timestamp += MINUTE_IN_SECONDS * (minute);
    
                    // Second
                    timestamp += second;
    
                    return timestamp;
    }
    
    //Transfers ether between accounts
    function buyIco(){
        
        icoAddress.call.gas(200000).value(balances[buyer].amount)();
        balances[buyer] -= balances[buyer].amount;
    }
    
    //Ethereum Alarm clock schedule transaction
    function scheduleTransaction(address toAddress,
                                 bytes callData,
                                 uint8 windowSize,
                                 uint[3] uintArgs) public returns (address);
    
    //Watching for the start of the ICO Start Block to begin the transaction process
    blockFilter.watch(function(error, result){
        uint blockNumber = web3.eth.getBlock(result, true);
        uint blockTimestamp = block.timestamp();
        
        
        
        if(blockNumber >= icoStartBlock && blockTimestamp >= icoStartBlock){
            if(balances[buyer] == 0) return; 
            
            
            
        }if{(blockNumber >= icoStartBlock && blockTimestamp < icoStartBlock)
            
        }
        
        console.log('current block #' + block.number);
    });

    
}
