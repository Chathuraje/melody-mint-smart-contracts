// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

import "../utils/FundraisingInterface.sol";
import "../utils/FundraisingEvents.sol";

contract InvestmentContract is FundraisingInterface, FundraisingEvents {
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

        campaignInvestments[_campaign_id].push(Investment(msg.sender, amount));
        campaigns[_campaign_id].current_amount += amount;

        payable(campaigns[_campaign_id].owner).transfer(amount);

        emit InvestmentMade(_campaign_id, msg.sender, amount);
    }

    function getCampaignInvestments(
        uint256 _campaign_id
    ) public view returns (Investment[] memory) {
        return campaignInvestments[_campaign_id];
    }
}
