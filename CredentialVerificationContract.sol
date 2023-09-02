// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CredentialVerificationContract {
    struct Credential {
        uint256 credentialId;
        address owner;
        string name;
        string description;
        string issuer;
        bool verified;
    }

    mapping(uint256 => Credential) public credentials;
    uint256 public credentialCount;

    event CredentialIssued(uint256 indexed credentialId, address indexed owner, string name, string issuer);
    event CredentialVerified(uint256 indexed credentialId);

    constructor() {
        credentialCount = 0;
    }

    function issueCredential(
        string memory _name,
        string memory _description,
        string memory _issuer
    ) external {
        require(bytes(_name).length > 0, "Name must not be empty");
        require(bytes(_issuer).length > 0, "Issuer must not be empty");

        uint256 credentialId = credentialCount;
        credentials[credentialId] = Credential(credentialId, msg.sender, _name, _description, _issuer, false);
        credentialCount++;

        emit CredentialIssued(credentialId, msg.sender, _name, _issuer);
    }

    function verifyCredential(uint256 _credentialId) external {
        require(credentials[_credentialId].owner == msg.sender, "Only the owner can verify the credential");

        credentials[_credentialId].verified = true;

        emit CredentialVerified(_credentialId);
    }
}
