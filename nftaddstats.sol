// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract nftaddstats is ERC721 {
    using Strings for uint256;

    // A mapping from token ID to card statistics
    mapping(uint256 => CardStats) private _tokenCardStats;

    // The metadata base URI
    string private _baseURI;

    // A struct for the card statistics
    struct CardStats {
        uint256 attack;
        uint256 defense;
    }

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) ERC721(name, symbol) {
        _baseURI = baseURI;
    }

    function setBaseURI(string memory baseURI) public {
        _baseURI = baseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURI;
    }

    function setCardStats(
        uint256 tokenId,
        uint256 attack,
        uint256 defense
    ) public {
        require(_exists(tokenId), "MyNFT: Token does not exist");
        CardStats memory stats = CardStats({attack: attack, defense: defense});
        _tokenCardStats[tokenId] = stats;
    }

    function getCardStats(
        uint256 tokenId
    ) public view returns (uint256 attack, uint256 defense) {
        require(_exists(tokenId), "MyNFT: Token does not exist");
        CardStats memory stats = _tokenCardStats[tokenId];
        return (stats.attack, stats.defense);
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(_exists(tokenId), "MyNFT: URI query for nonexistent token");
        return string(abi.encodePacked(_baseURI, tokenId.toString(), ".json"));
    }
}
