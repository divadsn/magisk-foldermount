#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
LOG="$MODDIR/mount.log"

# This script will be executed in late_start service mode
# More info in the main Magisk thread

until [ $sdstatus == "1" ]; do
	
	for var in `ls /mnt/runtime/default`; do
    	if echo "$var" | grep -Eq '[0-9a-fA-F]{4}-[0-9a-fA-F]{4}'; then
        	EXTSDPATH=/mnt/media_rw/$var/
        	break
    	fi
	done
	
    if grep -q $var /proc/mounts; then
        sdstatus=1
        echo "SD mounted: $(date) \n" >> $LOG
    else
        sleep 2
    fi
done

fmount -r