#!/bin/sh
CWD=$(pwd)
rm -f $CWD/tagfiles.tar.gz
pushd $CWD/tagfiles
tar cvzf tagfiles.tar.gz *
popd
mv -v $CWD/tagfiles/tagfiles.tar.gz $CWD/
exit 1


