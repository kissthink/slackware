#!/bin/sh
CWD=$(pwd)
rm -f $CWD/minimal-14.1.tar.gz
pushd $CWD/minimal-14.1
tar cvzf minimal-14.1.tar.gz *
popd
mv -v $CWD/minimal-14.1/minimal-14.1.tar.gz $CWD/
exit 1


