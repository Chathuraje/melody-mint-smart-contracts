// SPDX-License-Identifier: MIT
// This contract defines a UserManagement contract that facilitates user registration, retrieval, and deletion.

pragma solidity ^0.8.0;

import "../utils/Ownable.sol";
import "../models/Users.sol";
import "../events/UsersEvents.sol";

contract UserManagement is Ownable, Users, UsersEvents {
    // Function to register a new user.
    function registerUser(
        bytes32 _user_hash
    ) public newUser returns (address, bytes32) {
        users[msg.sender] = User(_user_hash, msg.sender); // Assign user data to the caller's wallet address.
        emit UserRegistered(msg.sender, _user_hash); // Emit an event indicating user registration.

        return (msg.sender, _user_hash); // Return the user's wallet address and user hash.
    }

    // Function to get user information by address.
    function getUser(
        address _user_address
    ) public view onlyOwner returns (bytes32, address) {
        User memory user = users[_user_address]; // Retrieve user data based on the provided address.
        return (user.user_hash, user.wallet_address); // Return the user's hash and wallet address.
    }

    // Function to delete the caller's user account.
    function deleteUser() public onlyUser {
        bytes32 user_hash = users[msg.sender].user_hash; // Retrieve the user hash before deletion.
        delete users[msg.sender]; // Delete the user data associated with the caller's address.
        emit UserDeleted(msg.sender, user_hash); // Emit an event indicating user deletion.
    }
}
