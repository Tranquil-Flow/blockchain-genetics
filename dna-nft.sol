// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFT is ERC721URIStorage {
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _metadataUrl
    ) ERC721(_name, _symbol) {
    }

    struct DNA {
        cGene1 gene1; 
    }

    enum cGene1 {
        Red,
        Orange,
        Yellow
    }
    CGene1 public cGene1;

    function createChild() external {
        uint parentIDA;
        uint parentIDB;
        cGene1 parentAGene = IERC721(parentIDA).DNA.gene1();
        cGene1 parentBGene = IERC721(parentIDB).DNA.gene1();

        // compare order on enum. highest value becomes the childGene and is added to data for minting
        cGene1 childGene;

        // mint

    }

    function contractURI() public view returns (string memory) {
        return tokenURI(1);
    }
}
        // _safeMint(msg.sender, 1); // Token ID 1
        // _setTokenURI(1, _metadataUrl);