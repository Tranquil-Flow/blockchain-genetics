pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

error MustOwnOrganism();
error NoReproductionRequestToCancel();
error ReproductionNotRequested();

contract GeneticNFT is ERC721 {
    enum EyeColor { BLUE, GREEN, BROWN } // BLUE is most recessive, BROWN is most dominant
    enum BloodType { O, A, B, AB } // O is most recessive, AB is most dominant

    struct Traits {
        EyeColor eyeColor;
        BloodType bloodType;
        uint height;
        uint hairGrowthRate;
    }

    struct Organism {
        Traits traits;
        bytes32 dnaSequence;
    }

    Organism[] public organisms;
    mapping (uint => uint) public reproductionApprovals;

    uint public geneticVariation = 10; // genetic variation range a trait can shift during reproduction

    constructor() ERC721("GeneticNFT", "GNFT") {}

    function requestReproduction(uint _organism1Id, uint _organism2Id) public {
        if (!(ownerOf(_organism1Id) == msg.sender || ownerOf(_organism2Id) == msg.sender)) {
            revert MustOwnOrganism();
        }
        reproductionApprovals[_organism1Id] = _organism2Id;
    }

    function cancelReproductionRequest(uint _organism1Id) public {
        if (ownerOf(_organism1Id) != msg.sender) {
            revert MustOwnOrganism();
        }
        if (reproductionApprovals[_organism1Id] == 0) {
            revert NoReproductionRequestToCancel();
        }
        delete reproductionApprovals[_organism1Id];
    }

    function approveReproduction(uint _organism1Id, uint _organism2Id) public {
        if (reproductionApprovals[_organism1Id] != _organism2Id) {
            revert ReproductionNotRequested();
        }
        if (!(ownerOf(_organism1Id) == msg.sender || ownerOf(_organism2Id) == msg.sender)) {
            revert MustOwnOrganism();
        }
        reproduce(_organism1Id, _organism2Id);
    }

    function reproduce(uint _organism1Id, uint _organism2Id) private {
        Organism storage organism1 = organisms[_organism1Id];
        Organism storage organism2 = organisms[_organism2Id];

        bytes32 randomHash = keccak256(abi.encodePacked(blockhash(block.number - 1), blockhash(block.number - 2), blockhash(block.number - 3), msg.sender, _organism1Id, _organism2Id));
        uint randomResult = uint(randomHash);

        // Enum Traits
        EyeColor childEyeColor = EyeColor(getDominantTrait(uint(organism1.traits.eyeColor), uint(organism2.traits.eyeColor)));
        BloodType childBloodType = BloodType(getDominantTrait(uint(organism1.traits.bloodType), uint(organism2.traits.bloodType)));

        // Uint Traits
        uint childHeight = mutateValue((randomResult % 2 == 0) ? organism1.traits.height : organism2.traits.height);
        uint childHairGrowthRate = mutateValue((randomResult % 2 == 0) ? organism1.traits.hairGrowthRate : organism2.traits.hairGrowthRate);

        Traits memory childTraits = Traits(childEyeColor, childBloodType, childHeight, childHairGrowthRate);
        bytes32 childDnaSequence = keccak256(abi.encodePacked(childEyeColor, childBloodType, childHeight, childHairGrowthRate));

        organisms.push(Organism(childTraits, childDnaSequence));
        uint newOrganismId = organisms.length - 1;

        _mint(msg.sender, newOrganismId);
    }

    function getDominantTrait(uint _trait1, uint _trait2) private pure returns (uint) {
        return (_trait1 > _trait2) ? _trait1 : _trait2;
    }

    function mutateValue(uint _value) private view returns (uint) {
        int mutation = int(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % (2 * geneticVariation + 1)) - int(geneticVariation);
        int newValue = int(_value) + mutation;
        return (newValue < 0) ? 0 : uint(newValue);
    }
}