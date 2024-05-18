// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SingleContract is ERC721, Ownable {
    string private _collectionMetaDataURI;
    uint256 private _nextTokenId;

    constructor(
        string memory _collectionName,
        string memory _collection_symbol,
        string memory _collection_meta_data,
        address _initial_owner
    ) ERC721(_collectionName, _collection_symbol) Ownable(_initial_owner) {
        _collectionMetaDataURI = _collection_meta_data;
    }

    function mint(address _to) public returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(_to, tokenId);

        return tokenId;
    }

    function getAllNFTs() public view returns (uint256[] memory) {
        uint256[] memory tokenIds = new uint256[](_nextTokenId);

        for (uint256 i = 0; i < _nextTokenId; i++) {
            tokenIds[i] = i;
        }

        return tokenIds;
    }

    function getAllNFTsWithOwners() public view returns (address[] memory) {
        address[] memory tokenIds = new address[](_nextTokenId);

        for (uint256 i = 0; i < _nextTokenId; i++) {
            tokenIds[i] = ownerOf(i);
        }

        return tokenIds;
    }

    function getSingleNFT(uint256 _tokenId)
        public
        view
        returns (address, uint256)
    {
        return (ownerOf(_tokenId), _tokenId);
    }
}
