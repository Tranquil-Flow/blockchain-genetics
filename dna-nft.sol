pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GeneticNFT is ERC721 {
    enum EyeColor { BLUE, GREEN, BROWN }
    enum BloodType { A, B, AB, O }

    struct cGene {
        EyeColor eyeColor;
        BloodType bloodType;
    }

    struct aGene {
        uint height;
        uint hairGrowthRate;
    }

    struct Creature {
        cGene characteristics;
        aGene attributes;
        bytes32 dnaSequence;
    }

    uint public mutationRange = 10; // mutation range an aGene can shift during breeding

    function createCreature(EyeColor _eyeColor, BloodType _bloodType, uint _height, uint _hairGrowthRate) public {
        cGene memory _characteristics = cGene(_eyeColor, _bloodType);
        aGene memory _attributes = aGene(_height, _hairGrowthRate);

        bytes32 dnaSequence = keccak256(abi.encodePacked(_eyeColor, _bloodType, _height, _hairGrowthRate));

        creatures.push(Creature(_characteristics, _attributes, dnaSequence));
        uint newCreatureId = creatures.length - 1;

        _mint(msg.sender, newCreatureId);
    }

    function breed(uint _creature1Id, uint _creature2Id) public {
        Creature storage creature1 = creatures[_creature1Id];
        Creature storage creature2 = creatures[_creature2Id];

        bytes32 randomHash = keccak256(abi.encodePacked(blockhash(block.number - 1), blockhash(block.number - 2), blockhash(block.number - 3), msg.sender, _creature1Id, _creature2Id));
        uint randomResult = uint(randomHash);

        EyeColor childEyeColor = (randomResult % 2 == 0) ? creature1.characteristics.eyeColor : creature2.characteristics.eyeColor;
        BloodType childBloodType = (randomResult % 3 == 0) ? creature1.characteristics.bloodType : creature2.characteristics.bloodType;
        uint childHeight = mutateValue((randomResult % 2 == 0) ? creature1.attributes.height : creature2.attributes.height);
        uint childHairGrowthRate = mutateValue((randomResult % 2 == 0) ? creature1.attributes.hairGrowthRate : creature2.attributes.hairGrowthRate);

        bytes32 childDnaSequence = keccak256(abi.encodePacked(childEyeColor, childBloodType, childHeight, childHairGrowthRate));

        createCreature(childEyeColor, childBloodType, childHeight, childHairGrowthRate, childDnaSequence);
    }

    function mutateValue(uint _value) private view returns (uint) {
        int mutation = int(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % (2 * mutationRange + 1)) - int(mutationRange);
        int newValue = int(_value) + mutation;
        return (newValue < 0) ? 0 : uint(newValue);
    }
}