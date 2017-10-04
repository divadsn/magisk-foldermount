#!/system/bin/sh

MODDIR=${0%/*}
LOG="$MODDIR/mount.log"

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
