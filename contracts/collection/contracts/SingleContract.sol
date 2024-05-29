// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SingleContract is ERC721, Ownable {
    string private _collectionMetaDataURI;
    uint256 private _nextTokenId;

    mapping(uint256 => uint256) private _nftPrices;

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

    function setPrice(uint256 _tokenId, uint256 _price) public {
        require(
            ownerOf(_tokenId) == msg.sender,
            "You are not the owner of this NFT"
        );
        _nftPrices[_tokenId] = _price;
    }

    function getPrice(uint256 _tokenId) public view returns (uint256) {
        return _nftPrices[_tokenId];
    }

    function getAllNFTs() public view returns (uint256[] memory) {
        uint256[] memory tokenIds = new uint256[](_nextTokenId);

        for (uint256 i = 0; i < _nextTokenId; i++) {
            tokenIds[i] = i;
        }

        return tokenIds;
    }

    struct NFTInfo {
        address owner;
        uint256 price;
    }

    function getAllNFTsWithOwners() public view returns (NFTInfo[] memory) {
        NFTInfo[] memory nftInfos = new NFTInfo[](_nextTokenId);

        for (uint256 i = 0; i < _nextTokenId; i++) {
            nftInfos[i] = NFTInfo({owner: ownerOf(i), price: _nftPrices[i]});
        }

        return nftInfos;
    }

    function getSingleNFT(
        uint256 _tokenId
    ) public view returns (address, uint256, uint256) {
        return (ownerOf(_tokenId), _tokenId, _nftPrices[_tokenId]);
    }

    function buyNFT(uint256 _tokenId) public payable {
        address owner = ownerOf(_tokenId);
        require(owner != msg.sender, "You already own this NFT");
        require(msg.value > 0, "You need to pay for this NFT");

        address payable ownerPayable = payable(owner);
        ownerPayable.transfer(msg.value);

        _transfer(owner, msg.sender, _tokenId);
    }

    function transferNFT(uint256 _tokenId, address _to) public {
        address owner = ownerOf(_tokenId);
        require(owner == msg.sender, "You are not the owner of this NFT");

        _transfer(owner, _to, _tokenId);
    }
}
