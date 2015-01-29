==========
StripSlack (c) Niki Kovacs <info@microlinux.fr>
==========

Last revision: Wed Jan 28 11:43:08 CET 2015


  * Introduction
  * StripSlack features
  * Installation
  * Migration
  * Support
  * Documentation


    ####################
    # WORK IN PROGRESS #
    ####################


Introduction
------------

Users who want a minimal system can configure this fairly easily with
distributions like CentOS, Debian, Arch, Crux, Gentoo, LFS, etc. 

The Slackware Linux distribution is built differently. The user is supposed to
install full package groups to obtain a coherent system. These package groups
mix packages required for a basic system with those needed for some more
specific configurations. Thus, a user who wants to configure a file server
without a GUI ends up with the full monty of KDE-specific libraries, and the
average desktop user has a full collection of web and file servers on his
machine. While this is not really a problem, sometimes the need for a more
stripped-down system may arise. This is where StripSlack comes in.

Seasoned Slackware users may remember ZipSlack(tm), a minimal Slackware system
supposed to be installed on a DOS partition, and which took only 170 MB of
drive space. StripSlack strives to provide a similar coherent minimal system
for recent Slackware releases. 


StripSlack features
-------------------

StripSlack basically enables you to do the following:

  * Boot in console mode.

  * Use the Bash shell.

  * Edit text files using Vim.

  * Display system documentation (man and info pages, HOWTOs, FAQs)

  * Manage disks and filesystems.

  * Build an initrd.

  * Connect to a network.

  * Manage packages through the network using slackpkg.

  * Connect remotely using SSH.

  * Work using Git.  

  * Etc.

The file 'PACKAGES.txt' provides a list of all the packages included in
StripSlack. You might also check out 'SKIP.txt' to have an overview of
everything that's been left out. 


Installation
------------

In order to avoid painstakingly picking each single package, use the provided
set of tagfiles to install the core system. These are plain text files
supposed to automate the potentially tedious package installation process,
like a bone-headed version of Red Hat Enterprise Linux' Kickstart files.

Boot the Slackware installation DVD (or the first CD). Select your keyboard
layout, login as root and partition your hard disk, but don't start the
installer yet.

Bring up your network interface, for example:

  root@slackware:/# dhcpcd eth0 

The Slackware installation environment already sports an empty '/tag'
directory for a set of tagfiles, so let's use it.

  # cd /tag 

Grab the set of tagfiles from the server:

  # wget http://www.microlinux.fr/slackware/stripslack-14.1/tagfiles.tar.gz 

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

Once you've reached the last step of the installation process, do not reboot
yet. StripSlack doesn't ship the HUGE kernel. You have to chroot into the
installed system, build an initrd and configure LILO to boot the GENERIC
kernel. 


Migration
---------

You may use the script 'stripslack.sh' to strip an existing Slackware
installation and turn it into StripSlack. The script uses 'slackpkg', so make
sure you have configured a valid mirror in '/etc/slackpkg/mirrors'. 

  # cd
  # git clone https://github.com/kikinovak/slackware
  # cd slackware/stripslack-14.1
  # ./stripslack.sh


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! BIG FAT WARNING! THIS WILL FLAY YOUR HAMSTER ALIVE !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


In the days and weeks to come, there will be some discussion around StripSlack
on LQ, and some honing and fine-tuning is to be expected. Some packages will
be added, others may be removed. Just use the 'stripslack.sh' script to keep
up-to-date.


Support
-------

There's an ongoing discussion thread about StripSlack on LinuxQuestions.org.
Post all your questions, suggestions and bug reports there.


Documentation
-------------

The LFS book:

  * http://www.linuxfromscratch.org/lfs/view/stable/

The BLFS book:

  * http://www.linuxfromscratch.org/blfs/view/stable/

The somewhat outdated "Linux From Slack" article on the Slackware-fr.org site:

  * http://wiki.slackware-fr.org/installation:articles:linux_from_slack

Vincent Batts' Minimal Slackware Installation:

  * http://www.slackware.com/~vbatts/minimal/


------------------------------------------------------------------------------
# vim: syntax=txt
