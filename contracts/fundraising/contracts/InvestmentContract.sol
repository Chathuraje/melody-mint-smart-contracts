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

    function distributeRoyaltiesToInvestors(
        uint256 _campaign_id,
        uint256 _earnings_amount
    ) public onlyAfterDeadline(_campaign_id) {
        Campaign storage campaign = campaigns[_campaign_id];

        require(
            campaign.current_amount >= campaign.goal,
            "Fundraising goal not reached"
        );

        uint256 totalAmount = _earnings_amount;
        uint256 distributionPercentage = campaign.distribution_percentage;

        Investment[] storage investments = campaignInvestments[_campaign_id];

        // Loop through investments and distribute earnings
        for (uint256 i = 0; i < investments.length; i++) {
            Investment storage investment = investments[i];

            uint256 amountToDistribute = (investment.amount *
                distributionPercentage) / 100;

            // Ensure the contract has enough funds to distribute
            require(
                totalAmount >= amountToDistribute,
                "Insufficient funds for distribution"
            );

            // Update total amount remaining to distribute
            totalAmount -= amountToDistribute;

            // Transfer funds to investor
            payable(investment.donor).transfer(amountToDistribute);
        }

        // Emit event
        emit RoyaltiesDistributed(_campaign_id, _earnings_amount - totalAmount);
    }
}
