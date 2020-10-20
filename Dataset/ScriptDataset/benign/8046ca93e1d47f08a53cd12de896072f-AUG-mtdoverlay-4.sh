        ROOTFSDATA_BLKDEV=`cat /proc/mtd | grep "rootfs_data" | cut -d':' -f1`
        if [ "mtd7" == "${ROOTFSDATA_BLKDEV}" ];then
	    mount -t jffs2 /dev/mtdblock7  /overlay/
        elif [ "mtd6" == "${ROOTFSDATA_BLKDEV}" ];then
	    mount -t jffs2 /dev/mtdblock6  /overlay/
        fi
	mkdir -p /overlay/root /overlay/work
	mkdir -p /tmp/mnt
	fopivot /overlay/root /overlay/work /rom 1
