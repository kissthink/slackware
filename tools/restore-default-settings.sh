#!/bin/bash
#
# restore-default-settings.sh
UTILISATEURS=$(ls /home)
echo
for UTILISATEUR in $UTILISATEURS; do
  rm -rf /home/$UTILISATEUR/.config
  echo ":: Restoring default desktop settings for user $UTILISATEUR."
  cp -R /etc/skel/.config /home/$UTILISATEUR/
  chown -R $UTILISATEUR:users /home/$UTILISATEUR/.config
done
echo
