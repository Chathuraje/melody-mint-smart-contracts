// SPDX-License-Identifier: UNLICENSED
// This contract defines a Fundraising contract that facilitates fundraising campaigns.

pragma solidity ^0.8.9;

contract Fundraising {
    // Struct to represent a fundraising campaign.
    struct Campaign {
        string fundraiser_name; // Name of the fundraiser.
        uint256 goal; // Goal amount in wei.
        uint256 distribution_percentage; // Percentage of funds to distribute to investors.
        uint256 start_date; // Start date of the campaign.
        uint256 end_date; // End date of the campaign.
        uint256 current_amount; // Current raised amount in wei.
        bool disabled; // Flag indicating if the campaign is disabled.
        uint256 created_date; // Creation date of the campaign.
        string metadata_hash; // Hash of metadata related to the campaign.
        address owner; // Address of the campaign owner.
    }

    // Struct to represent an investment made in a campaign.
    struct Investment {
        address donor; // Address of the donor.
        uint256 amount; // Investment amount in wei.
    }

    // Mapping to store campaign data indexed by campaign ID.
    mapping(uint256 => Campaign) internal campaigns;

    // Mapping to store investments made in each campaign indexed by campaign ID.
    mapping(uint256 => Investment[]) internal campaignInvestments;

    uint256 internal number_Of_campaigns = 0; // Counter for the number of campaigns.

    // Modifier to check if a campaign is enabled.
    modifier onlyIfEnabled(uint256 _campaign_id) {
        require(!campaigns[_campaign_id].disabled, "Campaign is disabled");
        _;
    }

    // Modifier to check if the current time is before the campaign deadline.
    modifier onlyBeforeDeadline(uint256 _campaign_id) {
        require(
            block.timestamp < campaigns[_campaign_id].end_date,
            "Deadline has passed"
        );
        _;
    }

    // Modifier to check if the current time is after the campaign deadline.
    modifier onlyAfterDeadline(uint256 _campaign_id) {
        require(
            block.timestamp >= campaigns[_campaign_id].end_date,
            "Deadline has not passed"
        );
        _;
    }

    // Modifier to check if the fundraising goal of a campaign is not reached.
    modifier onlyIfGoalNotReached(uint256 _campaign_id) {
        require(
            campaigns[_campaign_id].current_amount <
                campaigns[_campaign_id].goal,
            "Fundraising goal reached"
        );
        _;
    }

    // Modifier to check if the fundraising goal of a campaign is reached.
    modifier onlyIfGoalReached(uint256 _campaign_id) {
        require(
            campaigns[_campaign_id].current_amount >=
                campaigns[_campaign_id].goal,
            "Fundraising goal not reached"
        );
        _;
    }

    // Modifier to check if the caller is the owner of the campaign.
    modifier onlyCampaignOwner(uint256 _campaign_id) {
        require(
            msg.sender == campaigns[_campaign_id].owner,
            "Only campaign owner can call this function"
        );
        _;
    }

    // Modifier to check if the caller is not the owner of the campaign.
    modifier onlyNonCampaignOwner(uint256 _campaign_id) {
        require(
            msg.sender != campaigns[_campaign_id].owner,
            "Campaign owner cannot invest in own campaign"
        );
        _;
    }

    // Modifier to check if the fundraising percentage is valid (<= 100).
    modifier validFundraisingPercentage(uint256 distribution_percentage) {
        require(
            distribution_percentage <= 100,
            "Invalid fundraising percentage"
        );
        _;
    }
}
