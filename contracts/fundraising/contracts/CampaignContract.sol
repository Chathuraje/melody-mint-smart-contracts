// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "../utils/FundraisingInterface.sol";
import "../utils/FundraisingEvents.sol";

contract CampaignContract is FundraisingInterface, FundraisingEvents {
    function createCampaign(
        string memory _fundraiser_name,
        uint256 _goal,
        uint256 _distribution_percentage,
        uint256 _start_date,
        uint256 _end_date,
        string memory _metadata_hash
    )
        public
        validFundraisingPercentage(_distribution_percentage)
        returns (uint256)
    {
        Campaign storage campaign = campaigns[number_Of_campaigns];

        campaign.fundraiser_name = _fundraiser_name;
        campaign.goal = _goal;
        campaign.distribution_percentage = _distribution_percentage;
        campaign.start_date = _start_date;
        campaign.end_date = _end_date;
        campaign.current_amount = 0;
        campaign.metadata_hash = _metadata_hash;
        campaign.disabled = false;
        campaign.created_date = block.timestamp;
        campaign.owner = msg.sender;

        emit CampaignCreated(
            number_Of_campaigns,
            _fundraiser_name,
            _goal,
            _distribution_percentage,
            _start_date,
            _end_date,
            _metadata_hash,
            msg.sender
        );

        number_Of_campaigns++;

        return number_Of_campaigns - 1;
    }

    function setCampaingDisabled(
        uint256 _campaign_id
    ) public onlyCampaignOwner(_campaign_id) {
        campaigns[_campaign_id].disabled = true;

        emit CampaignDisabled(_campaign_id);
    }

    function getCampaign(
        uint256 _campaign_id
    )
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            uint256,
            uint256,
            bool,
            uint256,
            string memory,
            address
        )
    {
        Campaign memory campaign = campaigns[_campaign_id];
        return (
            campaign.fundraiser_name,
            campaign.goal,
            campaign.start_date,
            campaign.end_date,
            campaign.current_amount,
            campaign.disabled,
            campaign.created_date,
            campaign.metadata_hash,
            campaign.owner
        );
    }

    function updateCampaignMetadata(
        uint256 _campaign_id,
        string memory _metadata_hash
    ) external onlyCampaignOwner(_campaign_id) {
        campaigns[_campaign_id].metadata_hash = _metadata_hash;

        emit CampaignMetadataUpdated(_campaign_id, _metadata_hash);
    }

    function getAllCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory _campaigns = new Campaign[](number_Of_campaigns);
        for (uint256 i = 0; i < number_Of_campaigns; i++) {
            _campaigns[i] = campaigns[i];
        }
        return _campaigns;
    }
}
