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
        string memory _collection_symbol,
        string memory _collection_meta_data,
        address _owner_address
    )
        internal
        notCollectionExists(_collectionName, _collection_symbol)
        returns (address)
    {
        SingleContract newCollection = new SingleContract(
            _collectionName,
            _collection_symbol,
            _collection_meta_data,
            _owner_address
        );

        collections[_collectionName] = CollectionDetails({
            name: _collectionName,
            symbol: _collection_symbol,
            metaData: _collection_meta_data,
            contractAddress: address(newCollection),
            owner_address: address(_owner_address)
        });

        emit CollectionCreated(_collectionName, address(newCollection));

        return address(newCollection);
    }

    function getCollectionByCollectionAddress(
        address _collectionAddress
    ) public view returns (CollectionDetails memory) {
        SingleContract collection = SingleContract(_collectionAddress);

        return collections[collection.name()];
    }
}
