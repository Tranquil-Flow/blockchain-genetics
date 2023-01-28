# blockchain-genetics
Genetics system with inheritence pattern based on dominant/recessive genes

Ideas
[] Merkle Tree for NFT to store family tree?

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

## Info

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