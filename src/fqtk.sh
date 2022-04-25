#!/bin/bash
#print the options
usage () {
  echo ""
  echo "This program provides several scripts to perform common tasks on sequences in standard FASTQ format"
  echo ""
  echo "For user manual please go to: https://github.com/raymondkiu/fqtk"
  echo ""
  echo "Usage: fqtk [options] FASTQ"
  echo ""
  echo "Options:"
  echo " -a Rename FASTQ identifier for FASTQ reads. Optionally with /1 or /2. Usage: ./fqtk -a R1.FASTQ NEWIDENTIFIER /1"
  echo " -q Print FASTQ stats"
  echo " -t Convert FASTQ to FASTA. Usage: ./fqtk -t FASTQ > NEWFILENAME"
  echo " -r Print FASTQ stats in tabular format"
  echo " -h Print usage and exit"
  echo " -v Print version and exit"
  echo ""
  echo "Version 1.0 (2022)"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}

version (){
echo "fqtk v1.0"
}


FILE=$2
name=$3
sequence=$4

rename1(){
if [ -e "$FILE" ];then
:
else
    echo "$FILE file does not seem to exist. Program will now exit."
    exit 1
fi

cat $FILE | awk '{print (NR%4 == 1) ? "@'$name'" ++i "'$sequence'": $0}' 
}


fastqstats () {
if [ -e "$FILE" ];then
:
else
    echo "$FILE file does not seem to exist. Program will now exit."
    exit 1
fi
COUNT=$(cat $FILE|echo $((`wc -l`/4)))
READ=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $FILE)
SIZE=$(awk 'BEGIN{sum=0;}{if(NR%4==2){sum+=length($0);}}END{print sum;}' $FILE)
filesize=$(du -sh $FILE|awk '{print $1}')
MaxRead=$(awk 'NR%4==2{print length($0)}' $FILE|sort -n|tail -n 1)
MinRead=$(awk 'NR%4==2{print length($0)}' $FILE|sort -n|head -n 1)

echo "Sample: $FILE"
echo "File size: $filesize"
echo "Total bases: $SIZE"
echo "Reads: $COUNT"
echo "Max read length: $MaxRead"
echo "Min read length: $MinRead"
echo "Mean read length: $READ"
exit 0
}
fastq2fasta (){
if [ -e "$FILE" ];then
:
else
    echo "$FILE file does not seem to exist. Program will now exit."
    exit 1
fi

sed -n '1~4s/^@/>/p;2~4p' $FILE
}

fastqtabular () {
if [ -e "$FILE" ];then
:
else
    echo "$FILE file does not seem to exist. Program will now exit."
    exit 1
fi
COUNT=$(cat $FILE|echo $((`wc -l`/4)))
READ=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $FILE)
SIZE=$(awk 'BEGIN{sum=0;}{if(NR%4==2){sum+=length($0);}}END{print sum;}' $FILE)
filesize=$(du -sh $FILE|awk '{print $1}')
MaxRead=$(awk 'NR%4==2{print length($0)}' $FILE|sort -n|tail -n 1)
MinRead=$(awk 'NR%4==2{print length($0)}' $FILE|sort -n|head -n 1)

# Print info in tabular format, -e is for backslash, -n for new line:
echo -n -e "SampleID\t";
echo -n -e "Size\t";
echo -n -e "Total_bases\t";
echo -n -e "Reads\t";
echo -n -e "MaxRL\t";
echo -n -e "MinRL\t";
echo -e "MeanRL\t";

echo -n -e "$FILE\t"
echo -n -e "$filesize\t"
echo -n -e "$SIZE\t"
echo -n -e "$COUNT\t"
echo -n -e "$MaxRead\t"
echo -n -e "$MinRead\t"
echo -e "$READ"
exit 0
}

# Skip over processed options
shift $((OPTIND-1))
# check for mandatory positional parameters, only 1 positional argument will be checked
if [ $# -lt 1 ]; then
   echo "Missing optional argument or positional argument, please supply your fastq reads"
   echo ""
   echo "Options: ./fqtk -h"
   echo ""
   echo ""
   exit 1
fi

# Call options
while getopts ':aqtrhv' opt;do
  case $opt in
    a) rename1; exit;;
    q) fastqstats; exit;;
    t) fastq2fasta; exit;;
    r) fastqtabular; exit;;
    h) usage; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
   esac
done

shift $((OPTIND-1))
if [ $OPTIND -eq 1 ];then
   echo "Missing optional argument"
   echo ""
   echo "Options: ./fqtk -h"
   echo ""
   exit 1
fi
