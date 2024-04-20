// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../utils/MelodyMintOwnable.sol";
import "../utils/UserInterface.sol";
import "../utils/UserEvents.sol";

contract UserContract is MelodyMintOwnable, UserInterface, UserEvents {
    function registerUser(
        bytes32 _user_hash
    ) public newUser returns (address, bytes32) {
        users[msg.sender] = User(_user_hash, msg.sender);
        emit UserRegistered(msg.sender, _user_hash);

        return (msg.sender, _user_hash);
    }

    function getUser(
        address _user_address
    ) public view onlyOwner returns (bytes32, address) {
        User memory user = users[_user_address];
        return (user.user_hash, user.wallet_address);
    }

    function deleteUser() public onlyUser {
        bytes32 user_hash = users[msg.sender].user_hash;
        delete users[msg.sender];
        emit UserDeleted(msg.sender, user_hash);
    }
}
