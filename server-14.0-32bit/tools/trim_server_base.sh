#!/bin/sh
#
# trim_server_base.sh
#
# This script prepares the system before building or installing the Microlinux
# Server. It removes unneeded packages and installs needed ones. 
#
# You should configure slackpkg and run 'slackpkg update' before calling it.
#

CWD=$(pwd)
PKGINFO=/tmp/pkg_database
CRUFT=$(egrep -v '(^\#)|(^\s+$)' $CWD/pkglists/server-base-remove)
INSTALL=$(egrep -v '(^\#)|(^\s+$)' $CWD/pkglists/server-base-add)

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
echo "| Checking for packages to te removed from your system..."
echo "+=============================================================================="
echo
sleep 3
for PACKAGE in $CRUFT; do
  if [ -r $PKGINFO/$PACKAGE ] ; then
    /sbin/removepkg ${PACKAGE} 
  fi
done

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

if [ -z "$PACKAGES" ]; then
  continue
else
  /usr/sbin/slackpkg install $PACKAGES
fi

rm -rf $PKGINFO

echo
echo "+=============================================================================="
echo "| Your system is ready for building/installing Microlinux 14.0 Server."
echo "+=============================================================================="
echo
echo 
