// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SingleContract is ERC721 {
    constructor(
        string memory _collectionName,
        string memory _collectionSymbol
    ) ERC721(_collectionName, _collectionSymbol) {}
}