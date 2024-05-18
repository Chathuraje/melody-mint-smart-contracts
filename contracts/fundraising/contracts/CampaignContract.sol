// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "../utils/FundraisingInterface.sol";
import "../utils/FundraisingEvents.sol";
import "../../collection/CollectionsContract.sol";

contract CampaignContract is
    FundraisingInterface,
    FundraisingEvents,
    CollectionsContract
{
    function createCampaign(
        string memory _fundraiser_name,
        uint256 _goal,
        uint256 _distribution_percentage,
        uint256 _start_date,
        uint256 _end_date,
        string memory _campaign_meta_data,
        string memory _collection_name,
        string memory _collection_meta_data,
        string memory _collection_symbol
    )
        public
        validFundraisingPercentage(_distribution_percentage)
        returns (uint256)
    {
        Campaign storage campaign = campaigns[number_Of_campaigns];

        address collection_address;
        collection_address = createCollection(
            _collection_name,
            _collection_symbol,
            _collection_meta_data,
            msg.sender
        );

        campaign.fundraiser_name = _fundraiser_name;
        campaign.goal = _goal;
        campaign.distribution_percentage = _distribution_percentage;
        campaign.start_date = _start_date;
        campaign.end_date = _end_date;
        campaign.current_amount = 0;
        campaign.campaign_meta_data = _campaign_meta_data;
        campaign.disabled = false;
        campaign.created_date = block.timestamp;
        campaign.owner = msg.sender;
        campaign.collection_address = collection_address;

        emit CampaignCreated(
            number_Of_campaigns,
            _fundraiser_name,
            _goal,
            _distribution_percentage,
            _start_date,
            _end_date,
            _campaign_meta_data,
            msg.sender,
            collection_address
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
            uint256,
            bool,
            uint256,
            string memory,
            address,
            address
        )
    {
        Campaign memory campaign = campaigns[_campaign_id];
        return (
            campaign.fundraiser_name,
            campaign.goal,
            campaign.distribution_percentage,
            campaign.start_date,
            campaign.end_date,
            campaign.current_amount,
            campaign.disabled,
            campaign.created_date,
            campaign.campaign_meta_data,
            campaign.owner,
            campaign.collection_address
        );
    }

    function updateCampaignMetadata(
        uint256 _campaign_id,
        string memory _metadata_hash
    ) external onlyCampaignOwner(_campaign_id) {
        campaigns[_campaign_id].campaign_meta_data = _metadata_hash;

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
