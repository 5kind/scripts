#!/bin/sh
bakdir=/sdcard/Download/by-name
[ ! -e $bakdir ] && mkdir -p $bakdir
basedata=$(basename $(realpath /dev/block/by-name/userdata))

for block in /dev/block/by-name/* ;do
	baseblock=$(basename $block)
	if [ $baseblock != userdata ] && ! echo "$basedata" | grep -q "${baseblock}[0-9]*$" ;then
        echo "$block -> $bakdir/$baseblock.img"
	    dd if=$block of=$bakdir/$baseblock.img
    else
        echo "Skip the backup of $block"
    fi
done
