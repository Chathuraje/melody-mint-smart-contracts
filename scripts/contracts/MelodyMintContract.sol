// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./utils/Ownable.sol";
import "./libraries/UserManagement.sol";
import "./libraries/FundraisingManagment.sol";

contract MelodyMintContract is Ownable, UserManagement, FundraisingManagment {
    constructor() Ownable() {}
}
