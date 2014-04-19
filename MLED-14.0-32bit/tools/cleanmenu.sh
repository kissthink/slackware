#!/bin/bash
#
# cleanmenu.sh
# (c) Niki Kovacs, 2008

CWD=$(pwd)
ENTRIESDIR=$CWD/desktop
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="  /usr/share/applications \
            /opt/openoffice4/share/xdg"

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Updating $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

