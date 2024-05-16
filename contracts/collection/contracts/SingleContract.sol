// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SingleContract is ERC721 {
    string private _collectionMetaDataURI;

    constructor(
        string memory _collectionName,
        string memory _collection_symbol,
        string memory _collection_meta_data
    ) ERC721(_collectionName, _collection_symbol) {
        _collectionMetaDataURI = _collection_meta_data;
    }

    function getCollectionMetaDataURI() public view returns (string memory) {
        return _collectionMetaDataURI;
    }
}
