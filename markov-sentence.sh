#!/bin/sh
FILE=$1
WORDSTOPRINT=$2
FIRSTWORD=""
SECONDWORD=""
THIRDWORD=""
COMBINED=""
FOURTHWORD=""
LINE=""
SPACE=" "
FINAL=""
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
echo "$LINE"
printf "\n"

while [[ $WORDSTOPRINT != 0 ]]; do
  let "WORDSTOPRINT -= 1"
  FIRSTWORD=$(echo "$LINE" | tr -t '[:blank:]' '[\n*]' | awk 'FNR == 2 {print}')
  #echo $FIRSTWORD
  SECONDWORD=$(echo "$LINE" | tr -t '[:blank:]' '[\n*]' | awk 'FNR == 3 {print}')
  #echo $SECONDWORD
  THIRDWORD=$(echo "$LINE" | tr -t '[:blank:]' '[\n*]' | awk 'FNR == 4 {print}')
  #echo $THIRDWORD
  COMBINED="$FIRSTWORD $SECONDWORD $THIRDWORD"
  #printf "\n"
  #echo $COMBINED
  #cat $FILE | grep "^$COMBINED"
  FOURTHWORD=$(grep "^$COMBINED" $FILE | $SHUF | tr -t '[:blank:]' '[\n*]' | awk 'FNR == 4 {print}')
  #echo $FOURTHWORD
  COMBINED="$FIRSTWORD $SECONDWORD $THIRDWORD $FOURTHWORD"
  #echo $COMBINED
  LINE=$COMBINED
  FINAL+=$FOURTHWORD$SPACE

done
echo $FINAL







#Use awk
