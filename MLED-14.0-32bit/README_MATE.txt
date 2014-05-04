Sun May  4 08:06:35 CEST 2014

Moving to MATE
--------------

Here's a step by step guide for managing today's huge batch of updates and
moving MLED to MATE.

1. Switch to init 3:

   # init 3

2. Edit /etc/slackpkg/slackpkgplus.conf:

   SLACKPKGPLUS=on
   VERBOSE=2
   PKGS_PRIORITY=( mate:.* microlinux:.* )
   REPOPLUS=( mate microlinux )
   MIRRORPLUS['mate']=http://slackware.org.uk/msb/14.0/1.6/x86/
   MIRRORPLUS['microlinux']=http://www.microlinux.fr/slackware/MLED-14.0-32bit/

3. Import GPG keys and update package information:

   # slackpkg update gpg
   # slackpkg update

4. Import the Microlinux configuration scripts:

   # git clone https://github.com/kikinovak/slackware

   NOTE: A simple 'git pull' on an existing Git tree would probably result in
   a series of warnings, since the Github repository has been recreated from
   scratch recently. It's better to delete any remnants and reimport it.

5. Trim your base Slackware installation. This will remove unneeded packages
   and install some dependencies for MLED:

   # cd slackware/MLED-14.0-32bit/tools
   # ./trim_desktop_base.sh

6. Install the MATE desktop environment:

   # slackpkg install mate

7. Now get your MLED packages in sync:

   # slackpkg clean-system
   # slackpkg upgrade-all
   # slackpkg install microlinux

8. Install MLED's customized desktop menu entries:

   # cd slackware/MLED-14.0-32bit/tools
   # ./cleanmenu.sh

   NOTE: these menu entries are only available in english, german and french.
   If you're running your desktop in a different language, you might want to
   keep your default application entries.

9. The 'user-settings-mate' package provides a nice default configuration for
   the MATE desktop, but only for newly created users. If you want to use this
   configuration for existing users, just delete their existing ~/.config
   directory:

   # su - <your_user>
   $ rm -rf .config/

   NOTE: this step will reset existing configurations for applications like
   SMplayer or Transmission, but this is only a small price to pay.

10. Define MATE as your main desktop:

   $ xwmconfig 
   
   SELECT DEFAULT WINDOW MANAGER FOR X: xinitrc.mate-session

11. Switch back to init 4:

   # init 4

12. Have fun!


-- Niki Kovacs <info@microlinux.fr>

