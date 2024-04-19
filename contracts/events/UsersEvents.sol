// SPDX-License-Identifier: MIT
// This contract defines events related to user registration and deletion.

pragma solidity ^0.8.0;

contract UsersEvents {
    // Event emitted when a new user is registered.
    event UserRegistered(address indexed userAddress, bytes32 userHash);

    // Event emitted when a user is deleted.
    event UserDeleted(address indexed userAddress, bytes32 userHash);
}
