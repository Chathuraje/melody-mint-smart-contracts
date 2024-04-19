// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Fundraising {
    struct Campaign {
        string fundraiser_name;
        uint256 goal;
        uint256 startDate;
        uint256 endDate;
        bool disabled;
        uint256 createdDate;
        string metadataHash;
        address owner;
    }

    struct Investment {
        address donor;
        uint256 amount;
    }

    mapping(uint256 => Campaign) internal campaigns;
    mapping(uint256 => Investment[]) internal campaignInvestments;
    uint256 internal numberOfCampaigns = 0;

    modifier onlyIfEnabled(uint256 _campaignId) {
        require(!campaigns[_campaignId].disabled, "Campaign is disabled");
        _;
    }

    modifier onlyBeforeDeadline(uint256 _campaignId) {
        require(
            block.timestamp < campaigns[_campaignId].endDate,
            "Deadline has passed"
        );
        _;
    }

    modifier onlyAfterDeadline(uint256 _campaignId) {
        require(
            block.timestamp >= campaigns[_campaignId].endDate,
            "Deadline has not passed"
        );
        _;
    }

    modifier onlyIfGoalNotReached(uint256 _campaignId) {
        require(
            address(this).balance < campaigns[_campaignId].goal,
            "Fundraising goal reached"
        );
        _;
    }

    modifier onlyIfGoalReached(uint256 _campaignId) {
        require(
            address(this).balance >= campaigns[_campaignId].goal,
            "Fundraising goal not reached"
        );
        _;
    }

    modifier onlyCampaignOwner(uint256 _campaignId) {
        require(
            msg.sender == campaigns[_campaignId].owner,
            "Only campaign owner can call this function"
        );
        _;
    }

    modifier onlyNonCampaignOwner(uint256 _campaignId) {
        require(
            msg.sender != campaigns[_campaignId].owner,
            "Campaign owner cannot invest in own campaign"
        );
        _;
    }
}
