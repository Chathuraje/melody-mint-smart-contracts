// SPDX-License-Identifier: MIT
// This contract defines a Users contract for managing user registrations.

pragma solidity ^0.8.0;

contract Users {
    // Struct to represent a user.
    struct User {
        bytes32 user_hash; // Hash of user information.
        address wallet_address; // Ethereum wallet address of the user.
    }

    // Mapping to store user data indexed by wallet address.
    mapping(address => User) internal users;

    // Modifier to check if the caller is a registered user.
    modifier onlyUser() {
        require(
            users[msg.sender].wallet_address != address(0),
            "User not registered"
        );
        _;
    }

    // Modifier to check if the caller is a new user.
    modifier newUser() {
        require(
            users[msg.sender].wallet_address == address(0),
            "User already registered"
        );
        _;
    }
}
