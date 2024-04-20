// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract FundraisingEvents {
    event CampaignCreated(
        uint256 indexed campaign_id,
        string fundraiser_name,
        uint256 goal,
        uint256 distribution_percentage,
        uint256 start_date,
        uint256 end_date,
        string metadata_hash,
        address indexed owner
    );

    event InvestmentMade(
        uint256 indexed campaign_id,
        address investor,
        uint256 amount
    );

    event CampaignMetadataUpdated(
        uint256 indexed campaign_id,
        string metadata_hash
    );

    event CampaignDisabled(uint256 indexed campaign_id);
}
