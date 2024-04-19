// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Users {
    struct User {
        bytes32 userHash;
        address walletAddress;
    }

    mapping(address => User) internal users;

    modifier onlyUser() {
        require(
            users[msg.sender].walletAddress != address(0),
            "User not registered"
        );
        _;
    }

    modifier newUser() {
        require(
            users[msg.sender].walletAddress == address(0),
            "User already registered"
        );
        _;
    }
}
