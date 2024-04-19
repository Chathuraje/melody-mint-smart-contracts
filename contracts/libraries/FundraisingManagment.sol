// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../utils/Fundraising.sol";
import "../events/FundraisingEvents.sol";

contract FundraisingManagment is Fundraising, FundraisingEvents {
    function createCampaign(
        string memory _fundraiser_name,
        uint256 _goal,
        uint256 _startDate,
        uint256 _endDate
    ) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        campaign.fundraiser_name = _fundraiser_name;
        campaign.goal = _goal;
        campaign.startDate = _startDate;
        campaign.endDate = _endDate;
        campaign.disabled = false;
        campaign.createdDate = block.timestamp;
        campaign.owner = msg.sender;

        emit CampaignCreated(
            numberOfCampaigns,
            _fundraiser_name,
            _goal,
            _startDate,
            _endDate,
            msg.sender
        );

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function investToCampaign(
        uint256 _id
    )
        public
        payable
        onlyIfEnabled(_id)
        onlyBeforeDeadline(_id)
        onlyIfGoalNotReached(_id)
        onlyNonCampaignOwner(_id)
    {
        uint256 amount = msg.value;

        campaignInvestments[_id].push(Investment(msg.sender, amount));

        emit InvestmentMade(_id, msg.sender, amount);
    }

    function setCampaingDisabled(uint256 _id) public onlyCampaignOwner(_id) {
        campaigns[_id].disabled = true;

        emit CampaignDisabled(_id);
    }

    function getCampaign(
        uint256 _id
    )
        public
        view
        returns (
            string memory,
            uint256,
            uint256,
            uint256,
            bool,
            uint256,
            address
        )
    {
        Campaign memory campaign = campaigns[_id];
        return (
            campaign.fundraiser_name,
            campaign.goal,
            campaign.startDate,
            campaign.endDate,
            campaign.disabled,
            campaign.createdDate,
            campaign.owner
        );
    }

    function getCampaignInvestments(
        uint256 _id
    ) public view returns (Investment[] memory) {
        return campaignInvestments[_id];
    }

    function getAllCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory _campaigns = new Campaign[](numberOfCampaigns);
        for (uint256 i = 0; i < numberOfCampaigns; i++) {
            _campaigns[i] = campaigns[i];
        }
        return _campaigns;
    }
}
