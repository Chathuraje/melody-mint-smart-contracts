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
        string campaign_meta_data,
        address indexed owner,
        address collection_address
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

    event RoyaltiesDistributed(
        uint256 indexed campaign_id,
        uint256 earnings_amount
    );
}
