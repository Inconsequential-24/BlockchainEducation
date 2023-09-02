// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract CertificationContract {
    struct Certification {
        string name;
        address recipient;
        uint256 issueDate;
        uint256 expirationDate;
        bool isValid;
    }
    
    mapping(address => Certification[]) public certifications;
    
    event CertificationIssued(address indexed recipient, string name, uint256 issueDate, uint256 expirationDate);
    
    function issueCertification(address _recipient, string memory _name, uint256 _expirationDate) public {
        Certification memory certification = Certification({
            name: _name,
            recipient: _recipient,
            issueDate: block.timestamp,
            expirationDate: _expirationDate,
            isValid: true
        });
        
        certifications[_recipient].push(certification);
        
        emit CertificationIssued(_recipient, _name, block.timestamp, _expirationDate);
    }
    
    function verifyCertification(address _recipient, uint256 _index) public view returns (bool) {
        require(_index < certifications[_recipient].length, "Invalid certification index");
        Certification memory certification = certifications[_recipient][_index];
        return certification.isValid && certification.expirationDate >= block.timestamp;
    }
}
