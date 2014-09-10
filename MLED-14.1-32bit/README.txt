Microlinux Enterprise Desktop 14.1 32-bit
=========================================

The Microlinux Enterprise Desktop (MLED) is a full-blown production desktop
based on Slackware Linux and the KDE desktop environment, with many
enhancements. It is currently used by various small town halls, public
libraries, schools and local radio stations in South France. 

MLED is not some derivative Linux distribution. It consists of a collection of
over 100 custom packages installed on top of a trimmed-down Slackware base
system. A handful of KDE-related packages have been rebuilt for enhanced
functionality or visual consistency. A complete collection of codecs, plugins
and fonts provide a seamless desktop experience.

Despite the use of KDE, MLED tries to stay light on resources. The basic KDE
desktop has been reduced to a functional minimum, while resource hogs like
indexation or graphical effects are deactivated in the default user
configuration. This allows MLED to run satisfyingly even on older hardware,
consuming roughly 200 MB RAM with a loaded desktop on a 32-bit system.

Some KDE-specific applications like Konqueror, KMail, Calligra, KTorrent,
Kopete or Amarok are replaced by more lightweight and/or intuitive
counterparts like Mozilla Firefox, Mozilla Thunderbird, LibreOffice,
Transmission, Pidgin or Clementine. MLED follows a one-app-per-task policy and
strives to find a good balance between stability and functionality. All
non-KDE applications are visually integrated using the Oxygen-GTK theme.


Why MLED is based on KDE
------------------------

Over the past year, MLED development has gone through many changes and
iterations with a lot of trial and error involved. Various desktop
environments have been tested, with varying results. The choice of KDE as main
desktop environment is now motivated by several factors. 

  * Some of KDE's native applications like Dolphin, Okular, K3B, Gwenview or
    Digikam remain unrivalled. 
  
  * KDE ships many more applications than Xfce or MATE, which means less
    additional packages to take care of. 

  * The included KDM login manager avoids the hassle with GDM or SLIM. 
  
  * KWin has some powerful graphical effects included, so no need to rely on
    Compiz and the likes for that.
  
  * The default Oxygen theme offers a sober and corporate look while managing
    to avoid the "east german touch" that most GTK environments default to.

  * KDE's perennity seems safe compared to other desktop environments. 


Target audience
---------------

As far as the installation itself is concerned, MLED's main audience are users
with a bit of Linux and Slackware experience who want a rock-solid desktop
with a full set of applications where everything works out of the box, so they
can be immediately productive. Once MLED is installed, even Joe Sixpack or his
french counterpart Madame Michu can use it without even giving it a second
thought.


Hardware requirements
---------------------

The Microlinux Enterprise Desktop runs reasonably fast on seven year old
hardware. A dual-core processor with 1 GB RAM and a 40 GB hard disk will be
sufficient for the job.


Processor architectures and support cycles
------------------------------------------

MLED packages are available in binary form for both 32-bit and 64-bit
architectures. The package repositories also include a full set of sources and
build scripts. Starting with Slackware 14.1, MLED will do its best to follow
the Slackware support cycle of roughly five years per release. Hence the "E"
in "MLED" :o)


Installation Guide
------------------

The following instructions assume you already know how to install and
configure Slackware Linux. Read them carefully. The bits you skip will come
back and bite you.

MLED installs on top of a carefully selected Slackware base and doesn't ship
on its own installation ISO. All you need is a vanilla Slackware installation
disc and a working internet connection.

In order to avoid painstakingly picking each package or installing the whole
kitchen sink, the recommended method is to use the provided set of tagfiles.
These are plain text files supposed to automate the potentially tedious
package selection process, like a bone-headed version of Red Hat Enterprise
Linux' Kickstart files.

Boot the Slackware installation DVD (or the first CD). Select your keyboard
layout, login as root and partition your hard disk, but don't start the
installer yet.

Bring up your network interface, for example:

  root@slackware:/# dhcpcd eth0 

The Slackware installation environment already sports an empty '/tag'
directory for a set of tagfiles, so let's use it.

  # cd /tag 

Grab the set of tagfiles from the server:

  # wget http://www.microlinux.fr/slackware/MLED-14.1-32bit/tagfiles.tar.gz 

Unpack the downloaded archive:

  # tar xvzf tagfiles.tar.gz 

Your '/tag' directory should now contain a series of directories corresponding
to the Slackware package sets:

  # ls 
  a/ ap/ d/ e/ f/ k/ kde/ kdei/ l/ n/ t/ tcl/ x/ xap/ xfce/ y/

Now start the Slackware installer:

  # setup 

PACKAGE SERIES SELECTION: accept the default package selection, since the
tagfiles will override this and take care of selecting each package anyway.

SELECT PROMPTING MODE: tagpath - Use tagfiles in the subdirectories of a
custom path

Path to tagfiles: /tag

USE UTF-8 TEXT CONSOLE: Yes

CONFIRM STARTUP SERVICES TO RUN: accept the default selection.

SELECT DEFAULT WINDOW MANAGER FOR X: xinitrc.wmaker. This choice is only
temporary. I usually choose one of the more lightweight window managers like
WindowMaker or Fluxbox to configure X.

Finish the base Slackware installation. Eventually, chroot into the newly
installed environment, configure and build an initrd and replace the HUGE
kernel by the GENERIC kernel.

Exit and reboot. Don't define a user yet. We'll wait until the MLED user
profiles are installed.

I'm providing a few helper scripts and ready-to-use configuration files to
speed up the installation process. Grab the whole Microlinux file tree using
the following command:

  # cd 
  # git clone https://github.com/kikinovak/slackware 

Download and install the 'slackpkg+' plugin for 'slackpkg'. It's very
convenient for handling third-party repositories like MLED. 

  # links http://www.microlinux.fr/slackware/MLED-14.1-32bit/slackware

Grab the package from the 'ap/' directory and install it. It already comes
preconfigured for MLED.

Edit '/etc/slackpkg/mirrors' and choose a Slackware mirror according to your
geographical location, for example:

--8<---------- /etc/slackpkg/mirrors -----------------------------------------
...
# GERMANY (DE)
ftp://ftp.fu-berlin.de/unix/linux/slackware/slackware-14.1/
...
--8<--------------------------------------------------------------------------

  /!\ You might wonder why I use a german mirror even if I reside in France.
  That's because the admins of the french OVH mirror can't seem to get their
  act together. 

Update GPG keys:

  # slackpkg update gpg 

Update information about available packages:

  # slackpkg update 

In case you didn't use the set of tagfiles during the initial installation,
now's the time to eventually catch up on it. The 'MLED-14.1-32bit/tools/'
subdirectory provides a basic 'trim_desktop_base.sh' script that takes care of
two things:

  1. install needed packages
  2. get rid of unneeded packages

The script makes use of 'slackpkg', so make sure it's configured correctly.

  # cd slackware/MLED-14.1-32bit/tools/ 
  # ./trim_desktop_base.sh 

If you don't use the 'trim_desktop_base.sh' script, then you still have to
install the MPlayer plugin from 'extra/' manually:

  #  slackpkg install mplayerplug-in 

Now upgrade the base Slackware packages:

  # slackpkg upgrade-all 

You'll notice that some packages like kde-baseapps, kde-workspace,
kde-base-artwork, kde-wallpapers, k3b and MPlayer will be "upgraded", e. g.
replaced by an MLED package. Don't worry, this is normal. They have been
rebuilt either to strip some cruft or to offer extra functionality.

Now install the MLED package collection:

  # slackpkg install microlinux

You'll probably have to adjust your environment variables in
'/etc/profile.d/lang.sh'. Default variables are set to fr_FR.UTF8, since
MLED's main use is in France:

--8<---------- /etc/profile.d/lang.sh ----------------------------------------
...
export LANG=fr_FR.utf8
export LC_COLLATE=fr_FR.utf8
--8<--------------------------------------------------------------------------

English-speaking Slackware users will use something like this:

--8<---------- /etc/profile.d/lang.sh ----------------------------------------
...
export LANG=en_US.utf8
export LC_COLLATE=en_US.utf8
--8<--------------------------------------------------------------------------

The 'MLED-14.1-32bit/tools/' directory features the 'cleanmenu.sh' utility, a
small Bash script to clean up various desktop menu entries and make them
Joe-Sixpack-friendly. Run this utility:

  # cd MLED-14.1-32bit/tools/ 
  # ./cleanmenu.sh 

The script replaces many '*.desktop' files in '/usr/share/applications' and
similar locations by some custom-made menu entry files. For now, they're only
localized in english, french and german, so you may not want to run the script
if you use another language.

We're almost there. Here's what's left to be done.

  1. Configure the X.org server.

  2. Define one or more normal users for the system.
          
  3. Switch to default runlevel 4.

  4. Reboot.  


Maintenance
-----------

Here's a few tips & tricks to keep your MLED installation up-to-date.

Check out 'ChangeLog.txt' for new additions and/or updates.

If you want to know the state of your system, what's installed, what's not
installed, what updates are available, etc., you can do all this using one
single command:

  # slackpkg search microlinux | less 

Last but not least, application updates may sometimes overwrite the custom
menu entries with a default '*.desktop' file. If that is the case, simply rerun
the 'cleanmenu.sh' utility.


Support
-------

MLED is basically Slackware, with a bunch of extra packages and a few minor
configuration tweaks. The Slackware forum on LinuxQuestions.org is by far the
best place to get help on Slackware. Folks on LQ are a nice and competent
crowd. Just describe your ignorance, and there's a good chance your questions
will be answered. By the way, I'm user 'kikinovak' on LQ.


Credits
-------

Much of this work is based on great work that's been done before by some
excellent folks, and here's the place to give them credit :

  * Eric Hameleers for kindly mirroring the MLED project 

  * All the crew from SlackBuilds.org for their really precious work 

  * Daniel de Kok, who worked on what we called "Slick Linux" back in 2006 

  * Matteo Rossini for the great 'slackpkg+' tool 

  * And of course, Patrick Volkerding for creating the "Finest Linux Anywhere"


Support MLED development
------------------------

MLED is basically a one-man-project. If you want to support it, read more
about it on http://www.microlinux.fr/mled.php


Have fun!

Niki Kovacs <info@microlinux.fr> Tue Sep  9 21:01:54 CEST 2014

------------------------------------------------------------------------------
# vim: syntax=txt
# vim: set encoding=latin1
