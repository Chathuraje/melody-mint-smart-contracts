// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./SingleContract.sol";

import "../utils/CollectionsFactoryEvents.sol";
import "../utils/CollectionsFactoryInterface.sol";

contract CollectionsFactory is
    CollectionsFactoryEvents,
    CollectionsFactoryInterface
{
    function createCollection(
        string memory _collectionName,
        string memory _collectionSymbol
    ) public notCollectionExists(_collectionName) returns (address) {
        SingleContract newCollection = new SingleContract(
            _collectionName,
            _collectionSymbol
        );

        collections[_collectionName] = address(newCollection);

        emit CollectionCreated(_collectionName, address(newCollection));

        return address(newCollection);
    }
}
