# fqtk: a toolkit to perform common tasks on FASTQ reads
Rename FASTQ identifiers, print FASTQ statistics and convert FASTQ to FASTA. This program is written in Bash.

## Usage
```
This program provides several scripts to perform common tasks on sequences in standard FASTQ format

For user manual please go to: https://github.com/raymondkiu/fqtk

Usage: fqtk [options] FASTQ

Options:
 -a Rename FASTQ identifier for FASTQ reads. Optionally with /1 or /2. Usage: ./fqtk -a R1.FASTQ NEWIDENTIFIER /1
 -q Print FASTQ stats
 -t Convert FASTQ to FASTA. Usage: ./fqtk -t FASTQ > NEWFILENAME
 -r Print FASTQ stats in tabular format
 -h Print usage and exit
 -v Print version and exit

Version 1.0 (2022)
Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk
```

### To rename FASTQ identifiers
Some paired-end FASTQ may not have the classic suffixes /1 (forward) or /2 (reverse) which may cause downstream problems in several programs such as BWA (older versions).  That is when you need to rename the FASTQ to make it work. To do this
```
$ fqtk -a FASTQ abc /1
@abc1/1
NGATGGGGGCGATGCGCCGGGTTTACAGGGCCTGCTGCCAGACCGCCTGGGGCAGGAGATAAACCTTCGCCGGGGCGCGTATGCCGTCGGTGACAATATG
+SRR1038387.2 HWI-ST729:118489968:D0EB1ABXX:3:1101:1344:1927 length=100
#1:DDDFFHFHAHHIIJIGGIBHGEH@CEFDFFDECCABCDD?B@BDDBB7755:<?@8A::CDCDC38>>@BDBB<@B908?@>>5<<@9@########
@abc2/1
NCAAATATTTTGTGGATTATTTATATTGTTCTTTTTGTTATTATTATGCTGGAAAATGGGGTTCTACCTGCCGCATTTCTACCCGGCGATACATTATTAA
+SRR1038387.5 HWI-ST729:118489968:D0EB1ABXX:3:1101:1434:1955 length=100
#1=DDFFFHHHHFHJGIJIJJJIJJJJJJJJJJJJJJIJJJJJJJJJJJJJJJJJIJJJJJIIIJJJJJJJJJHHBFFFEEEEEDDDDDDDDDDEDEEDE
@abc3/1
NGTTTCTGTAACGAACCCTCCAATTATTTTATCTCCCGGACCAAATATCGTTGCTCCCGGGATAACTTCACCAATAATTGGTTCAAGAATATCTTCCTCG
+SRR1038387.7 HWI-ST729:118489968:D0EB1ABXX:3:1101:1297:1971 length=100
#1=DDFFFHHHHHJJJJJJJJJJJJIJJJJIJJJJJJJJJJJIIJJJJJJJJJJJJHHHFFDDDDDDEDDDDDDDDDEFDDABDDEDDDDDEEEEEDDCB
@abc4/1
NTCTTTAAATACCGGAGATACCGCCAATAGCTCTTCGGCGAGTTGTTTACGTGCTGCATTAGCTTGTTGATCGTTACCCTTTTCAATAACATTCATTAAA
+SRR1038387.10 HWI-ST729:118489968:D0EB1ABXX:3:1101:1602:1922 length=100
#4=DFFFFHHHHHJJJJJJJJJJJJJJJIIJJJJJJJJJJIIHHHHFFFFFEDDDEDDDEDDDDDDBDDCCDDAB@@CDDDDDCACDC>ACCDDEEE:@C
```
This program will add sequence order to this 1..2..3..4 and so on. Just leave the second positional argument empty if you do not want to add /1 or /2 at the back.
In order to save into a new fastq file, use the > sign:
```
$ fqtk -a FASTQ abc /1 > NEWFASTQ
```
It took around 3 mins to finish renaming a ~3.8G fastq file on 4 cpus and 4GB of RAM:
```
real    2m50.706s
user    0m26.429s
sys     0m12.584s
```

### To print FASTQ stats
```
$ fqtk -q FASTQ
Sample: NEWFASTQ.fastq
File size: 64K
Total bases: 400
Reads: 4
Max read length: 100
Min read length: 100
Mean read length: 100
```

### To print FASTQ stats in tabular format
```
$ fqtk -r FASTQ
SampleID	Size	Total_bases	Reads	MaxRL	MinRL	MeanRL	
NEWFASTQ.fastq	64K	400	4	100	100	100
```

### To convert FASTQ into FASTA
```
$ fqtk -t FASTQ
>abc1/1
NGATGGGGGCGATGCGCCGGGTTTACAGGGCCTGCTGCCAGACCGCCTGGGGCAGGAGATAAACCTTCGCCGGGGCGCGTATGCCGTCGGTGACAATATG
>abc2/1
NCAAATATTTTGTGGATTATTTATATTGTTCTTTTTGTTATTATTATGCTGGAAAATGGGGTTCTACCTGCCGCATTTCTACCCGGCGATACATTATTAA
>abc3/1
NGTTTCTGTAACGAACCCTCCAATTATTTTATCTCCCGGACCAAATATCGTTGCTCCCGGGATAACTTCACCAATAATTGGTTCAAGAATATCTTCCTCG
>abc4/1
NTCTTTAAATACCGGAGATACCGCCAATAGCTCTTCGGCGAGTTGTTTACGTGCTGCATTAGCTTGTTGATCGTTACCCTTTTCAATAACATTCATTAAA
```

All outputs will be in stdout so greater than sign ">" can be used to save outputs in a new file.

## Issues
Please report any issues to the [issues page](https://github.com/raymondkiu/fqtk/issues).

## Citation
If you use fqtk for results in your publication, please cite:
* Kiu R, *fqtk: A toolkit to perform common tasks on FASTQ reads*, **GitHub** `https://github.com/raymondkiu/fqtk`

## License
fqtk is a free software licensed under [GPLv3](https://github.com/raymondkiu/fqtk/blob/master/LICENSE)

## Author
Raymond Kiu | Raymond.Kiu@quadram.ac.uk | [@raymond_kiu](https://twitter.com/raymond_kiu)



