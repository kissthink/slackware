#!/bin/bash
LFTP=$(which lftp)
CWD=$(pwd)
LOCALDIR="$CWD/.."
REMOTESERVER="ftp.microlinux.fr"
REMOTEDIR="/html/slackware"
echo
if [[ -z $FTPUSER ]]; then
  read -p "FTP username: " FTPUSER
fi
if [[ -z $FTPPASS ]]; then
  PROMPT="FTP password: "
  while IFS= read -p "$PROMPT" -r -s -n 1 CHAR; do
    if [[ $CHAR == $'\0' ]]; then
      break
    fi
    PROMPT='*'
    FTPPASS+="$CHAR"
  done
  echo 
fi
$LFTP -c "set ftp:list-options -a;
open ftp://$FTPUSER:$FTPPASS@$REMOTESERVER;
set net:limit-rate 100000
lcd $LOCALDIR;
cd $REMOTEDIR;
mirror --continue --reverse --dereference --parallel=1 --exclude .git/ --delete --verbose "
