#!/bin/sh
FILE=$1
WORDSTOPRINT=$2
FIRSTWORD=""
SECONDWORD=""
THIRDWORD=""
COMBINED=""
FOURTHWORD=""
LINE=""
FINAL=""
#Run shuffle program
SHUF=$(command -v shuf)
if [ ! -x "$SHUF" ]; then
  if [ -x "./shuffle" ]; then
    SHUF="./shuffle"
  else
    echo "No shuffle program!" 1>& 2
    exit -1
  fi
fi

#Base cases
if [[ ! -f $FILE ]]; then
  echo "No file found"
  exit -1
fi

if [[ -z $2 ]]; then
  echo "No number argument supplied"
  exit -1
fi

if [[ $2 -lt 0 ]]; then
  echo "The argument number must be greater than 0"
  exit -1
fi

if [[ ! -r $FILE ]]; then
  echo "Cannot read '$FILE' due to permissions"
  exit -1
fi

#Get random line from shuffle.c
LINE=$($SHUF < $FILE | head -n 1)
#Prints until the argument $2 is met
while [[ $WORDSTOPRINT != 0 ]]; do
  #Grab words using awk by col
  FIRSTWORD=$(echo "$LINE" | awk '{print $2}')
  SECONDWORD=$(echo "$LINE" | awk '{print $3}')
  THIRDWORD=$(echo "$LINE" | awk '{print $4}')
  LINE="$FIRSTWORD $SECONDWORD $THIRDWORD"
  #Grabs a random line with the starting three words
  LINE=$(grep "^$LINE" $FILE | $SHUF | head -n 1)
  FOURTHWORD=$(echo "$LINE" | awk '{print " "$4}')
  #Grab the fourth word and add it to the final string
  FINAL+=$FOURTHWORD
  let "WORDSTOPRINT -= 1"
done
echo $FINAL
