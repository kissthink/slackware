#!/bin/bash
#
# stripslack.sh
#

CWD=$(pwd)
CATEGORIES="a ap d e f k kde kdei l n t tcl x xap xfce y" 
PKGADD=$CWD/PACKAGES.txt
PKGDEL=$CWD/SKIP.txt
PKGINFO=/tmp/pkg_database

echo "###################################" > $PKGADD
echo "# Packages included in StripSlack #" >> $PKGADD
echo "###################################" >> $PKGADD

echo "#######################################" > $PKGDEL
echo "# Packages not included in StripSlack #" >> $PKGDEL
echo "#######################################" >> $PKGDEL

for CATEGORY in $CATEGORIES; do
  FILE=$CWD/tagfiles/$CATEGORY/tagfile
  echo >> $PKGADD
  echo "# Package group [$CATEGORY]" >> $PKGADD
  echo >> $PKGADD
  awk -F: '$2 == "ADD" {print $1}' $FILE >> $PKGADD
  echo >> $PKGADD
  echo >> $PKGDEL
  echo "# Package group [$CATEGORY]" >> $PKGDEL
  echo >> $PKGDEL
  awk -F: '$2 == "SKP" {print $1}' $FILE >> $PKGDEL
  echo >> $PKGDEL
done

CRUFT=$(egrep -v '(^\#)|(^\s+$)' $PKGDEL)
INSTALL=$(egrep -v '(^\#)|(^\s+$)' $PKGADD)

rm -rf $PKGINFO
mkdir $PKGINFO

echo
echo "+=============================================================================="
echo "| Checking installed packages on your system..."
echo "+=============================================================================="
echo
sleep 3
for PACKAGE in $(find /var/log/packages); do
  printf "."
  PACKAGENAME=$(echo $PACKAGE |cut -f5 -d'/' |rev |cut -f4- -d'-' |rev)
  touch $PKGINFO/$PACKAGENAME
done

echo
echo
echo "+=============================================================================="
echo "| Checking for packages to be removed from your system..."
echo "+=============================================================================="
echo
sleep 3
for PACKAGE in $CRUFT; do
  if [ -r $PKGINFO/$PACKAGE ] ; then
    PACKAGES="$PACKAGES $PACKAGE"
  fi
done

if [ ! -z "$PACKAGES" ]; then
  /usr/sbin/slackpkg remove $PACKAGES
fi

unset PACKAGE
unset PACKAGES

echo 
echo "+=============================================================================="
echo "| Checking for packages to be installed on your system..."
echo "+=============================================================================="
echo 
sleep 3
for PACKAGE in $INSTALL; do
  if [ ! -r $PKGINFO/$PACKAGE ] ; then
    PACKAGES="$PACKAGES $PACKAGE"
  fi
done

if [ ! -z "$PACKAGES" ]; then
  /usr/sbin/slackpkg install $PACKAGES
fi

rm -rf $PKGINFO

echo
echo "+=============================================================================="
echo "| Your Slackware 14.1 installation has been trimmed successfully. "
echo "+=============================================================================="
echo
echo 

