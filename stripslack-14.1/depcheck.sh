#!/bin/bash
#
# depcheck.sh
#
# This script is a very basic dependency checker for Slackware Linux. It scans
# all the binaries in the PATH and reports any missing libraries.

for DIRECTORY in $(echo $PATH | sed 's/:/ /g'); do
  for FILE in $DIRECTORY/*; do
    echo -n "." 
    if [ $(file -b $FILE | cut -d' ' -f1) == 'ELF' ]; then
      if ldd $FILE | grep -q 'not found'; then
         echo "$FILE"
         ldd $FILE | grep 'not found' | awk '{print "Not found:", $1}'
      fi
    fi
  done
done
echo 
echo
