#!/bin/bash
find .. -name 'ChangeLog.cd' | xargs rm -f
find .. -name 'ChangeLog.rss' | xargs rm -f
find .. -name 'ChangeLog.txt.gz' | xargs rm -f
find .. -name 'CHECKSUMS.md5*' | xargs rm -f
find .. -name 'FILELIST.TXT' | xargs rm -f
find .. -name 'GPG-KEY' | xargs rm -f
find .. -name 'PACKAGES.TXT*' | xargs rm -f
find .. -name '*_microlinux.lst' | xargs rm -f
find .. -name '*_microlinux.meta' | xargs rm -f
find .. -name '*_microlinux.txt' | xargs rm -f
find .. -name '*_microlinux.txz.asc' | xargs rm -f
find .. -name '*_microlinux.txz.md5' | xargs rm -f

