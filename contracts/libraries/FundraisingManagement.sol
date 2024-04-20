// SPDX-License-Identifier: UNLICENSED
// This contract defines a FundraisingManagement contract for managing fundraising campaigns.

pragma solidity ^0.8.9;

import "../models/Fundraising.sol";
import "../events/FundraisingEvents.sol";

contract FundraisingManagement is Fundraising, FundraisingEvents {
    // Function to create a new fundraising campaign.
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
        Campaign storage campaign = campaigns[number_Of_campaigns]; // Get reference to the campaign at the current number of campaigns.

        // Set campaign parameters.
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

        // Emit an event indicating the creation of a new campaign.
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

        number_Of_campaigns++; // Increment the number of campaigns.

        return number_Of_campaigns - 1; // Return the ID of the newly created campaign.
    }

    // Function to invest in a fundraising campaign.
    function investToCampaign(
        uint256 _campaign_id
    )
        public
        payable
        onlyNonCampaignOwner(_campaign_id)
        onlyIfEnabled(_campaign_id)
        onlyIfGoalNotReached(_campaign_id)
        onlyBeforeDeadline(_campaign_id)
    {
        uint256 amount = msg.value;

        // Add the investment to the campaign investments array and update the current amount raised.
        campaignInvestments[_campaign_id].push(Investment(msg.sender, amount));
        campaigns[_campaign_id].current_amount += amount;

        // Transfer the invested amount to the campaign owner.
        payable(campaigns[_campaign_id].owner).transfer(amount);

        // Emit an event indicating the investment.
        emit InvestmentMade(_campaign_id, msg.sender, amount);
    }

    // Function to disable a campaign.
    function setCampaingDisabled(
        uint256 _campaign_id
    ) public onlyCampaignOwner(_campaign_id) {
        campaigns[_campaign_id].disabled = true;

        // Emit an event indicating the campaign was disabled.
        emit CampaignDisabled(_campaign_id);
    }

    // Function to retrieve campaign information.
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

    // Function to update campaign metadata.
    function updateCampaignMetadata(
        uint256 _campaign_id,
        string memory _metadata_hash
    ) external onlyCampaignOwner(_campaign_id) {
        campaigns[_campaign_id].metadata_hash = _metadata_hash;

        // Emit an event indicating the update of campaign metadata.
        emit CampaignMetadataUpdated(_campaign_id, _metadata_hash);
    }

    // Function to retrieve investments for a campaign.
    function getCampaignInvestments(
        uint256 _campaign_id
    ) public view returns (Investment[] memory) {
        return campaignInvestments[_campaign_id];
    }

    // Function to retrieve all campaigns.
    function getAllCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory _campaigns = new Campaign[](number_Of_campaigns);
        for (uint256 i = 0; i < number_Of_campaigns; i++) {
            _campaigns[i] = campaigns[i];
        }
        return _campaigns;
    }
}
