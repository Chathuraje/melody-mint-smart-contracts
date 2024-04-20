// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract NFT {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint256 public tokenCounter;
    mapping(uint256 => address) public tokenOwners;
    mapping(address => uint256) public balanceOf;
    mapping(uint256 => address) public approved;
    mapping(address => mapping(address => bool)) public operatorApprovals;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function mint(address _to) public {
        uint256 tokenId = tokenCounter;
        tokenOwners[tokenId] = _to;
        balanceOf[_to]++;
        totalSupply++;
        tokenCounter++;
    }

    function approve(address _to, uint256 _tokenId) public {
        require(msg.sender == tokenOwners[_tokenId], "NFT: Not the owner");
        approved[_tokenId] = _to;
    }

    function setApprovalForAll(address _to, bool _approved) public {
        operatorApprovals[msg.sender][_to] = _approved;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(
            _from == msg.sender ||
                approved[_tokenId] == msg.sender ||
                operatorApprovals[tokenOwners[_tokenId]][msg.sender],
            "NFT: Not approved"
        );
        require(tokenOwners[_tokenId] == _from, "NFT: Not the owner");
        tokenOwners[_tokenId] = _to;
        balanceOf[_from]--;
        balanceOf[_to]++;
        approved[_tokenId] = address(0);
    }
}
