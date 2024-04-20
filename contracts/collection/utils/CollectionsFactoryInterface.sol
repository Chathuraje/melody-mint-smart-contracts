// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract CollectionsFactoryInterface {
    mapping(string => address) public collections;

    modifier notCollectionExists(string memory _collectionName) {
        require(
            collections[_collectionName] == address(0),
            "Collection already exists"
        );
        _;
    }
}
