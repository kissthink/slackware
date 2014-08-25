#!/bin/bash
RSYNC=$(which rsync)
CWD=$(pwd)
LOCALSTUFF=$CWD/..
RSYNCUSER=kikinovak
SERVER=alphamule
SERVERDIR=/home/kikinovak/Public/slackware
$RSYNC -av $LOCALSTUFF --exclude '.git*' $RSYNCUSER@$SERVER:$SERVERDIR 

