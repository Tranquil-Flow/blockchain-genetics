# blockchain-genetics
Genetics system with inheritence pattern based on dominant/recessive genes

### Ideas
[ ] Merkle Tree for NFT to store family tree? Would also allow extraction of all ancestors DNA.
[ ] Consider more secure randomness with Chainlink VRF or Unifaction VOR
[ ] Capped vs uncapped traits

### Problems
[ ] How do unique new traits arise?
[ ] 

### To-Do
[ ] v2

## Genetic NFTs
Genetic NFT's can breed with one another to produce children, which take their genetics from a randomised combination of their parents DNA similar to biological life.

### v1
- Trait system with pre-defined traits that are represented by a single traits
- Basic reproduction system with fuzzing of adult DNA values to determine child DNA values.
- `enum` traits have 50/50 chance of inheriting from parent A or B
- GenotypicTraits (`uint`) is the average of a fuzzed value from parent A and B

### v2
- More refined system of trait expression to match real life's complexities. Have traits arise from multiple genes/alleles.
- Differentiate traits between GenotypicTraits and PhenotypicTraits, with the latter being observable traits that are imapcted by genotype as well as environmental factors
- Traits can uniquely arise through mutations in reproduction process.

# Biology Info

### Glossary
- **Chromosome**: A long DNA molecule with part or all of the genetic material of an organism. Chromosomes are located in the nucleus of cells and contain genes arranged in a specific sequence. Humans have 23 pairs of chromosomes.

- **DNA**: A molecule that carries the genetic instructions used in the growth, development, functioning, and reproduction of all known living organisms and many viruses. DNA is the hereditary material in humans and almost all other organisms.

- **Gene**: A segment of DNA on a chromosome that encodes instructions for making proteins or RNA molecules. Genes determine the characteristics and functions of an organism, influencing its physical and biochemical traits. They are the basic unit of heredity and play a crucial role in passing traits from parents to offspring.

- **Allele**: A variant form of a gene that is located at a specific position, or locus, on a chromosome. Alleles contribute to the organism's genotype and influence its phenotype. Different alleles can result in different observable traits.

- **Phenotype**: The set of observable characteristics or traits of an organism, resulting from the interaction of its genotype with the environment. This includes physical appearance, behavior, and biochemical properties.

- **Genotype**: The genetic constitution of an individual organism, often referring to a specific set of genes or alleles that code for particular traits. The genotype is a major influencing factor in the phenotype of the organism.

## Gene Types

### Characteristics (cGene)

cGene's use an `Enum` to define a phenotype. Different phenotypes are distinct.
The child genotype and its component alleles being dominant or recessive influences what phenotype is displayed.

Example: Eye Colour, Blood

`alleleRanking`: Ranking of each allele from most recessive to most dominant.

### Attributes (aGene)

aGene's use an `Uint` to define a phenotype. Different phenotypes have no absolute definition.
The child genotype and its component alleles values are used together to influence what the value of the phenotype is.

Example: Height, Hair Growth Rate

`inheritenceValueType`: Average (Child value is (Parent A + Parent B) / 2)), Variable (Child value is >= ParentLowerValue & <= ParentHighValue)
`inheritenceValueFuzz`: Applies a 'fuzz' to the uint, allowing for value to have a chance to change up to +- the defined %. 

## Expression of traits through allele combinations

Parents pass on traits or characteristics, such as eye colour and blood type, to their children through their genes. Some health conditions and diseases can be passed on genetically too.

Sometimes, one characteristic has many different forms. For example, blood type can be A, B, AB or O. Changes (or variations) in the gene for that characteristic cause these different forms.

Each variation of a gene is called an allele (pronounced ‘AL-eel’). These two copies of the gene contained in your chromosomes influence the way your cells work.

The combination of alleles that you have is called your genotype (e.g. AO). The observable trait that you have – (e.g. blood group A) – is your phenotype.

The two alleles in a gene pair are inherited, one from each parent. Alleles interact with each other in different ways. These are called inheritance patterns. Examples of inheritance patterns include:

- autosomal dominant – where the gene for a trait or condition is dominant, and is on a non-sex chromosome
- autosomal recessive – where the gene for a trait or condition is recessive, and is on a non-sex chromosome
- X-linked dominant – where the gene for a trait or condition is dominant, and is on the X-chromosome
- X-linked recessive – where the gene for a trait or condition is recessive, and is on the X-chromosome
- Y-linked – where the gene for a trait or condition is on the Y-chromosome
- co-dominant – where each allele in a gene pair carries equal weight and produces a combined physical characteristic

The most common interaction between alleles is a dominant/recessive relationship. An allele of a gene is said to be dominant when it effectively overrules the other (recessive) allele.

Eye colour and blood groups are both examples of dominant/recessive gene relationships.