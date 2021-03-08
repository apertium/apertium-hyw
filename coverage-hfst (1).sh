#!/bin/bash

CORPUS=$1
ANALYSER=$2
LG=$(echo $CORPUS | sed 's:.*\/::' | sed -r 's:(.*\..*)\..*\.txt.*:\1:') # get corpus prefix

TMPCORPUS=/tmp/$LG.corpus.txt

if [[ $1 =~ .*bz2 ]]; then
	CAT="bzcat"
else
	CAT="cat"
fi;

$CAT $CORPUS > $TMPCORPUS

echo "Generating hitparade (might take a bit!)"

cat $TMPCORPUS | apertium-destxt | hfst-proc -w $ANALYSER | apertium-retxt | sed 's/\$\s*/\$\n/g' > /tmp/$LG.parade.txt

echo "TOP UNKNOWN WORDS:"

cat /tmp/$LG.parade.txt | grep '\*' | sort | uniq -c | sort -rn | head -n20

TOTAL=`cat /tmp/$LG.parade.txt | wc -l`
KNOWN=`cat /tmp/$LG.parade.txt | grep -v '\*' | wc -l`
UNKNOWN=`cat /tmp/$LG.parade.txt | grep '\*' | wc -l`

PERCENTAGE=`calc $KNOWN/$TOTAL | sed 's/[\s\t]//g'`

echo "coverage: $KNOWN / $TOTAL ($PERCENTAGE)"
echo "remaining unknown forms: $UNKNOWN"

DATE=`date`;
echo -e $LG $DATE"\t"$KNOWN"/"$TOTAL"\t"$PERCENTAGE >> history.log
tail -1 history.log