// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationContract {
    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    mapping(uint256 => Donation) public donations;
    uint256 public donationCount;
    address public beneficiary;
    uint256 public totalDonations;

    event DonationReceived(uint256 indexed donationId, address indexed donor, uint256 amount);

    constructor(address _beneficiary) {
        beneficiary = _beneficiary;
    }

    function donate() external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");

        uint256 donationId = donationCount;
        donations[donationId] = Donation(msg.sender, msg.value, block.timestamp);
        donationCount++;
        totalDonations += msg.value;

        emit DonationReceived(donationId, msg.sender, msg.value);
    }

    function withdrawFunds() external {
        require(msg.sender == beneficiary, "Only the beneficiary can withdraw funds");

        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available for withdrawal");

        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "Failed to transfer funds to the beneficiary");
    }
}
