// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract UserInterface {
    struct User {
        bytes32 user_hash;
        address wallet_address;
    }

    mapping(address => User) internal users;


     modifier onlyUser() {
        require(
            users[msg.sender].wallet_address != address(0),
            "User not registered"
        );
        _;
    }

    modifier newUser() {
        require(
            users[msg.sender].wallet_address == address(0),
            "User already registered"
        );
        _;
    }
}
