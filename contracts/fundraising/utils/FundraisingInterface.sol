// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract FundraisingInterface {
    struct Campaign {
        string fundraiser_name;
        uint256 goal;
        uint256 distribution_percentage;
        uint256 start_date;
        uint256 end_date;
        uint256 current_amount;
        bool disabled;
        uint256 created_date;
        string metadata_hash;
        address owner;
    }

    struct Investment {
        address donor;
        uint256 amount;
    }

    mapping(uint256 => Campaign) internal campaigns;

    mapping(uint256 => Investment[]) internal campaignInvestments;

    uint256 internal number_Of_campaigns = 0;

    modifier onlyIfEnabled(uint256 _campaign_id) {
        require(!campaigns[_campaign_id].disabled, "Campaign is disabled");
        _;
    }

    modifier onlyBeforeDeadline(uint256 _campaign_id) {
        require(
            block.timestamp < campaigns[_campaign_id].end_date,
            "Deadline has passed"
        );
        _;
    }

    modifier onlyAfterDeadline(uint256 _campaign_id) {
        require(
            block.timestamp >= campaigns[_campaign_id].end_date,
            "Deadline has not passed"
        );
        _;
    }

    modifier onlyIfGoalNotReached(uint256 _campaign_id) {
        require(
            campaigns[_campaign_id].current_amount <
                campaigns[_campaign_id].goal,
            "Fundraising goal reached"
        );
        _;
    }

    modifier onlyIfGoalReached(uint256 _campaign_id) {
        require(
            campaigns[_campaign_id].current_amount >=
                campaigns[_campaign_id].goal,
            "Fundraising goal not reached"
        );
        _;
    }

    modifier onlyCampaignOwner(uint256 _campaign_id) {
        require(
            msg.sender == campaigns[_campaign_id].owner,
            "Only campaign owner can call this function"
        );
        _;
    }

    modifier onlyNonCampaignOwner(uint256 _campaign_id) {
        require(
            msg.sender != campaigns[_campaign_id].owner,
            "Campaign owner cannot invest in own campaign"
        );
        _;
    }

    modifier validFundraisingPercentage(uint256 distribution_percentage) {
        require(
            distribution_percentage <= 100,
            "Invalid fundraising percentage"
        );
        _;
    }
}
