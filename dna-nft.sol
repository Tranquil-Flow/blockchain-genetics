pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GeneticNFT is ERC721 {
    enum EyeColor { BLUE, GREEN, BROWN }
    enum BloodType { A, B, AB, O }

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

    uint public geneticVariation = 10; // genetic variation range a trait can shift during reproduction

    constructor() ERC721("GeneticNFT", "GNFT") {}

    function reproduce(uint _organism1Id, uint _organism2Id) public {
        Organism storage organism1 = organisms[_organism1Id];
        Organism storage organism2 = organisms[_organism2Id];

        bytes32 randomHash = keccak256(abi.encodePacked(blockhash(block.number - 1), blockhash(block.number - 2), blockhash(block.number - 3), msg.sender, _organism1Id, _organism2Id));
        uint randomResult = uint(randomHash);

        EyeColor childEyeColor = (randomResult % 2 == 0) ? organism1.traits.eyeColor : organism2.traits.eyeColor;
        BloodType childBloodType = (randomResult % 3 == 0) ? organism1.traits.bloodType : organism2.traits.bloodType;
        uint childHeight = mutateValue((randomResult % 2 == 0) ? organism1.traits.height : organism2.traits.height);
        uint childHairGrowthRate = mutateValue((randomResult % 2 == 0) ? organism1.traits.hairGrowthRate : organism2.traits.hairGrowthRate);

        Traits memory childTraits = Traits(childEyeColor, childBloodType, childHeight, childHairGrowthRate);
        bytes32 childDnaSequence = keccak256(abi.encodePacked(childEyeColor, childBloodType, childHeight, childHairGrowthRate));

        organisms.push(Organism(childTraits, childDnaSequence));
        uint newOrganismId = organisms.length - 1;

        _mint(msg.sender, newOrganismId);
    }

    function mutateValue(uint _value) private view returns (uint) {
        int mutation = int(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % (2 * geneticVariation + 1)) - int(geneticVariation);
        int newValue = int(_value) + mutation;
        return (newValue < 0) ? 0 : uint(newValue);
    }
}