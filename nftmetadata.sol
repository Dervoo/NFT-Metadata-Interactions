pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract nftmetadata is ERC721 {
    constructor() ERC721("MyNFT", "MFT") {}

    struct TokenMetadata {
        string name;
        string description;
        string image;
    }

    TokenMetadata[] private _tokenMetadata;

    function mint(
        address to,
        string memory name,
        string memory description,
        string memory image
    ) public returns (uint256) {
        uint256 tokenId = _tokenMetadata.length;
        _tokenMetadata.push(TokenMetadata(name, description, image));
        _mint(to, tokenId);
        return tokenId;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        require(_exists(tokenId), "URI query for nonexistent token");
        TokenMetadata memory metadata = _tokenMetadata[tokenId];
        string memory json = string(
            abi.encodePacked(
                "{",
                '"name":"',
                metadata.name,
                '",',
                '"description":"',
                metadata.description,
                '",',
                '"image":"',
                metadata.image,
                '",',
                "}"
            )
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(bytes(json))
                )
            );
    }
}

library Base64 {
    bytes private constant ALPHABET =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        uint256 i = 0;
        if (len % 3 == 1) {
            len += 2;
            data = abi.encodePacked(data, bytes2(0));
        } else if (len % 3 == 2) {
            len += 1;
            data = abi.encodePacked(data, bytes1(0));
        }
        string memory result = new string((4 * len) / 3);
        bytes memory resultBytes = bytes(result);
        for (uint256 i = 0; i < data.length; i += 3) {
            (uint256 a, uint256 b, uint256 c) = (
                i < data.length ? (uint256(uint8(data[i])), 1) : (0, 0),
                i + 1 < data.length ? (uint256(uint8(data[i + 1])), 1) : (0, 0),
                i + 2 < data.length ? (uint256(uint8(data[i + 2])), 1) : (0, 0)
            );
            uint256 resultIndex = (i * 4) / 3;
            uint256 c1 = (a << 16) | (b << 8) | c;
            resultBytes[resultIndex] = ALPHABET[c1 >> 18];
            resultBytes[resultIndex + 1] = ALPHABET[(c1 >> 12) & 0x3F];
            resultBytes[resultIndex + 2] = ALPHABET[(c1 >> 6) & 0x3F];
            resultBytes[resultIndex + 3] = ALPHABET[c1 & 0x3F];
        }
        return result;
    }
}
