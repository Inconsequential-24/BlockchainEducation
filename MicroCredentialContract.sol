// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MicroCredentialContract {
    struct MicroCredential {
        address recipient;
        string microCredentialType;
        string microCredentialData;
    }

    mapping(uint256 => MicroCredential) public microCredentials;
    uint256 public microCredentialCount;

    event MicroCredentialIssued(uint256 indexed microCredentialId, address indexed recipient, string microCredentialType);

    function issueMicroCredential(address recipient, string memory microCredentialType, string memory microCredentialData) external {
        uint256 microCredentialId = microCredentialCount;
        microCredentials[microCredentialId] = MicroCredential(recipient, microCredentialType, microCredentialData);
        microCredentialCount++;

        emit MicroCredentialIssued(microCredentialId, recipient, microCredentialType);
    }
}
