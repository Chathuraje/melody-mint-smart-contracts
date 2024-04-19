// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract FundraisingEvents {
    event CampaignCreated(
        uint256 indexed id,
        string fundraiserName,
        uint256 goal,
        uint256 startDate,
        uint256 endDate,
        address indexed owner
    );

    event InvestmentMade(
        uint256 indexed campaignId,
        address investor,
        uint256 amount
    );

    event CampaignDisabled(uint256 indexed id);
}
