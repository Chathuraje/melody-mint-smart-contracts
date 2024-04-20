// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./users/UsersContract.sol";
import "./fundraising/FundraisingContract.sol";
import "./collection/CollectionsContract.sol";

contract MelodyMintContract is
    UsersContract,
    FundraisingContract,
    CollectionsContract
{}
