// SPDX-License-Identifier: MIT
// This contract combines functionality from the Ownable contract, UserManagement library, and FundraisingManagement library.

pragma solidity ^0.8.0;

import "./utils/Ownable.sol";
import "./libraries/UserManagement.sol";
import "./libraries/FundraisingManagement.sol";
import "./libraries/NFTManagement.sol";

contract MelodyMintContract is
    Ownable,
    UserManagement,
    FundraisingManagement,
    NFTManagement
{
    constructor() Ownable() {} // Constructor inheriting from Ownable.
}
