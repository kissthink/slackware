#!/bin/sh
#

CWD=$(pwd)
SOURCEDIR="$CWD/../../MLES-14.0-source"
TEMPFILE="/tmp/all.txt"

echo "#####################" > $TEMPFILE
echo "# MLES package list #" >> $TEMPFILE
echo "#####################" >> $TEMPFILE

for PKGGROUP in ap d l multimedia n profile ; do
  echo >> $TEMPFILE
  echo "# $PKGGROUP" >> $TEMPFILE
  ls $SOURCEDIR/$PKGGROUP \
  >> $TEMPFILE
done
cat $TEMPFILE \
  | grep -v do_not_add_this_package \
  > $CWD/pkglists/packages-MLES

