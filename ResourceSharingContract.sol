// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ResourceSharingContract {
    struct Resource {
        uint256 resourceId;
        address owner;
        string title;
        string description;
        uint256 price;
        bool available;
    }

    mapping(uint256 => Resource) public resources;
    uint256 public resourceCount;

    event ResourceShared(uint256 indexed resourceId, address indexed owner, string title, uint256 price);

    constructor() {
        resourceCount = 0;
    }

    function shareResource(string memory _title, string memory _description, uint256 _price) external {
        require(bytes(_title).length > 0, "Title must not be empty");
        require(_price > 0, "Price must be greater than 0");

        uint256 resourceId = resourceCount;
        resources[resourceId] = Resource(resourceId, msg.sender, _title, _description, _price, true);
        resourceCount++;

        emit ResourceShared(resourceId, msg.sender, _title, _price);
    }

    function purchaseResource(uint256 _resourceId) external payable {
        require(resources[_resourceId].available, "Resource is not available");
        require(msg.value >= resources[_resourceId].price, "Insufficient funds");

        address payable owner = payable(resources[_resourceId].owner);
        uint256 payment = resources[_resourceId].price;

        resources[_resourceId].available = false;

        owner.transfer(payment);

        if (msg.value > payment) {
            payable(msg.sender).transfer(msg.value - payment);
        }
    }
}
