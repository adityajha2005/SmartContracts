// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Emission {
    uint256 public datacount = 0;
    
    struct Data {
        address walletid;
        string carbon;
        string date;
        uint256 fees;
    }
    
    event EmissionDate(
        address indexed walletid,
        string carbon,
        string indexed date,
        uint256 fees
    );
    
    mapping(uint256 => Data) public emissions;
    
    function createEmissionData(
        address walletAddress,
        string memory carbonValue,
        string memory dateValue
    ) public payable {
        require(msg.value > 0, "Fees should be greater than 0");
        datacount++;
        
        emissions[datacount] = Data(
            walletAddress,
            carbonValue,
            dateValue,
            msg.value
        );
        
        emit EmissionDate(walletAddress, carbonValue, dateValue, msg.value);
    }
    
    function collectFee(address payable _govID) public {
        require(
            msg.sender == _govID,
            "You are not authorized to collect the fees"
        );
        
        _govID.transfer(address(this).balance);
    }
}