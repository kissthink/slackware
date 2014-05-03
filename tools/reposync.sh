#!/bin/bash
RSYNC=$(which rsync)
CWD=$(pwd)
LOCALSTUFF=$CWD/..
RSYNCUSER=kikinovak
SERVER=nestor
SERVERDIR=/srv/httpd/vhosts/mirror/htdocs/microlinux
$RSYNC -av $LOCALSTUFF --exclude '.git*' $RSYNCUSER@$SERVER:$SERVERDIR 

