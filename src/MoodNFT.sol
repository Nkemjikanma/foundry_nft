// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// use openzeppelin base 64 to encode svg;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    //errors

    error MoodNFT_CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("MoodNFT", "MNFT") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mintNFT(string memory _tokenURI) public {
        s_tokenIdToUri[s_tokenCounter] = _tokenURI;

        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;

        s_tokenCounter++;
    }

    function flipMood(uint256 _tokenId) public {
        // only want the owner to be able to flip the mood
        if (ownerOf(_tokenId) != msg.sender) {
            revert MoodNFT_CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[_tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[_tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64";
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        string memory tokenMetadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "',
                            name(),
                            '", "description": "An NFT that reflects owners mood.", "attribures": [{"trait_type": "moodiness", "value":100}], "image": "',
                            imageURI,
                            '"  }'
                        )
                    )
                )
            )
        );

        return tokenMetadata;
    }
}
