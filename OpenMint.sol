// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Aaron is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {


    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    mapping(address => uint) maxMint;
  
     uint MAX_SUPPLY = 10000;
     
    constructor() ERC721("Aaron", "AAR") {}

   

    function safeMint(address to, string memory uri)
        public
    {
        require(_tokenIdCounter.current() <= MAX_SUPPLY, "We have reached the limit of minting, sorry");
        require(maxMint[msg.sender] <= 5, "You can only mint max of five tokens to this address");
        uint tokenId = _tokenIdCounter.current();
        maxMint[msg.sender]++;
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}