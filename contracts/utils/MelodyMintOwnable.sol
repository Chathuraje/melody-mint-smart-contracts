// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MelodyMintOwnable is Ownable {
    constructor() Ownable(msg.sender) {}
}
