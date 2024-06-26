// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract UserEvents {
    event UserRegistered(address indexed userAddress, bytes32 userHash);
    event UserDeleted(address indexed userAddress, bytes32 userHash);
}
