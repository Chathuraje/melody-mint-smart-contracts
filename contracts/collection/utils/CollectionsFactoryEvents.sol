// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract CollectionsFactoryEvents {
    event CollectionCreated(string collectionName, address contractAddress);

    modifier emitCollectionCreated(
        string memory _collectionName,
        address _contractAddress
    ) {
        _;
        emit CollectionCreated(_collectionName, _contractAddress);
    }
}
