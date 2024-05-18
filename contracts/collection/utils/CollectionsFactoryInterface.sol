// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract CollectionsFactoryInterface {
    struct CollectionDetails {
        string name;
        string symbol;
        string metaData;
        address contractAddress;
        address owner_address;
    }

    mapping(string => CollectionDetails) internal collections;

    modifier notCollectionExists(
        string memory _collectionName,
        string memory _collection_symbol
    ) {
        require(
            collections[_collectionName].contractAddress == address(0),
            "Collection already exists"
        );

        require(
            collections[_collection_symbol].contractAddress == address(0),
            "Collection already exists"
        );
        _;
    }
}
