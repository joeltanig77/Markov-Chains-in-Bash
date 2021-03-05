#!/bin/sh
PREVWORD="^"
FIRSTWORD="^^^"
SECONDWORD="^^"
#Reads from the text file to only read letters and change every upper case letter
#to lower case and read the word. Also delete any symbols that is not a letter
tr -c "a-zA-Z" '\n' | tr [:upper:] [:lower:] | grep '[a-zA-Z]'| while read WORD
do
  #If length is 1 and we are not a,i,o, skip it
  if [[ ${#WORD} == 1 ]] && [[ $WORD != [aio] ]]; then
    continue
  fi
  #If not a word with a vowel, skip
  if [[ $WORD != *[aeiou]* ]]; then
    continue
  fi
  #Print the new edited text
  echo "$FIRSTWORD $SECONDWORD $PREVWORD $WORD"
  FIRSTWORD="$SECONDWORD"
  SECONDWORD="$PREVWORD"
  PREVWORD="$WORD"
  continue
done
