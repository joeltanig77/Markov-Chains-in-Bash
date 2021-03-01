#!/bin/sh
PREVWORD="BEGIN"
tr -c "a-zA-Z" '\n'| grep '[a-zA-Z]'| while read WORD
do
  echo "$PREVWORD $WORD"
  PREVWORD="$WORD"
done
