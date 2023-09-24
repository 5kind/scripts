#!/bin/sh
# install config
BUSYBOX='/data/adb/magisk/busybox'
MODDIR='/data/adb/modules/busybox'
SYSTEM_BIN='/system/bin'
MODBIN="$MODDIR$SYSTEM_BIN"
MOUNTPOINT="$TMPDIR/system"
TMPBIN="$MOUNTPOINT/bin"
BUSY_LIST=$($BUSYBOX --list)
TOY_LIST=$(toybox)
REPLACE_LIST="cal
chcon
chgrp
chmod
chown
date
dd
env
expand
getopt
gunzip
gzip
head
microcom
mkfifo
mknod
mount
mountpoint
nsenter
od
rmmod
runcon
stat
swapoff
time
uname
unshare
vi
wc
whoami
xargs
"
# install busybox binary
mkdir -p $MOUNTPOINT $MODBIN
mount --bind /system $MOUNTPOINT 
cd $MODBIN
cp $BUSYBOX .
# install toybox link
for cmd in $TOY_LIST ;do
    [ ! -x "$TMPBIN/$cmd" ] && \
    ln -sf toybox $cmd 2>&1 >/dev/null
done
# install busybox link
for cmd in $BUSY_LIST ;do
    [ ! -x "$TMPBIN/$cmd" ] && \
    ln -sn busybox $cmd 2>&1 >/dev/null
done
# replace toybox link
for cmd in $REPLACE_LIST ;do
    ln -sf busybox $cmd 2>&1 >/dev/null
done
# end install
umount $MOUNTPOINT
# module.prop
module_prop="id=busybox	
name=Systemless Busybox	
version=1.0	
versionCode=1
author=Magisk
description=Magisk app built-in systemless busybox module
"
printf '%s' "$module_prop" > $MODDIR/module.prop
