// SPDX-License-Identifier: UNLICENSED
// This contract defines events related to fundraising campaigns.

pragma solidity ^0.8.9;

contract FundraisingEvents {
    // Event emitted when a new campaign is created.
    event CampaignCreated(
        uint256 indexed campaign_id, // ID of the campaign
        string fundraiser_name, // Name of the fundraiser
        uint256 goal, // Fundraising goal
        uint256 distribution_percentage, // Distribution percentage
        uint256 start_date, // Start date of the campaign
        uint256 end_date, // End date of the campaign
        string metadata_hash, // Metadata hash of the campaign
        address indexed owner // Owner of the campaign
    );

    // Event emitted when an investment is made to a campaign.
    event InvestmentMade(
        uint256 indexed campaign_id, // ID of the campaign
        address investor, // Address of the investor
        uint256 amount // Amount invested
    );

    // Event emitted when the metadata of a campaign is updated.
    event CampaignMetadataUpdated(
        uint256 indexed campaign_id, // ID of the campaign
        string metadata_hash // New metadata hash
    );

    // Event emitted when a campaign is disabled.
    event CampaignDisabled(uint256 indexed campaign_id); // ID of the campaign
}
