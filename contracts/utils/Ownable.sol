// SPDX-License-Identifier: MIT
// This contract defines an Ownable contract that provides a basic access control mechanism, allowing
// only the owner to execute certain functions.

pragma solidity ^0.8.0;

contract Ownable {
    address private owner; // Address of the owner of the contract.

    constructor() {
        owner = msg.sender; // Set the deployer's address as the owner upon contract creation.
    }

    // Modifier to restrict access to functions only to the owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _; // Continue executing the function if the condition is met.
    }
}
