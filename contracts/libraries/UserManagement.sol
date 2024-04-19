// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../utils/Ownable.sol";
import "../utils/Users.sol";
import "../events/UsersEvents.sol";

contract UserManagement is Ownable, Users, UsersEvents {
    function registerUser(
        bytes32 _userHash
    ) public newUser returns (address, bytes32) {
        users[msg.sender] = User(_userHash, msg.sender);
        emit UserRegistered(msg.sender, _userHash);

        return (msg.sender, _userHash);
    }

    function getUser(
        address _userAddress
    ) public view onlyOwner returns (bytes32, address) {
        User memory user = users[_userAddress];
        return (user.userHash, user.walletAddress);
    }

    function deleteUser() public onlyUser {
        bytes32 userHash = users[msg.sender].userHash;
        delete users[msg.sender];
        emit UserDeleted(msg.sender, userHash);
    }
}
