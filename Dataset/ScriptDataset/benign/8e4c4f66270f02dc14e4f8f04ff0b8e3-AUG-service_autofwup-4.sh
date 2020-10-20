	mounted=0
	DOWNLOADS_DIR=/var/downloads
	DOWNLOADS_PARTITION=$(awk -F: '/downloads/ { print $1 }' /proc/mtd)
	if [ -z $DOWNLOADS_PARTITION ]; then
		ulog autofwup status  "Skip to mount downloads partition, /dev/$DOWNLOADS_PARTITION"
	elif mount | grep "/dev/mtd.* on /tmp " > /dev/null; then
		echo /tmp already mounted on MTD partition
		mkdir -p /tmp/var/downloads
	else
		MTD_DEVICE=/dev/${DOWNLOADS_PARTITION}
		MTD_BLOCK_DEVICE=/dev/$(echo ${DOWNLOADS_PARTITION} | sed s/mtd/mtdblock/)
		mkdir -p ${DOWNLOADS_DIR} || echo No mount point for downloads storage.
		if mount -t jffs2 -o noatime $MTD_BLOCK_DEVICE ${DOWNLOADS_DIR}; then
			mounted=1
		else
			echo Downloads persistent storage mount failed, attempting format
			if ! flash_eraseall -j ${MTD_DEVICE}; then
				echo Format downloads persistent storage failed.  Perhaps mkfs.jffs not installed.  Giving up.
			else
				if mount -t jffs2 -o noatime ${MTD_BLOCK_DEVICE} ${DOWNLOADS_DIR}; then
					echo Format succeeded, downloads mount still failed.  Giving up.
				fi
			fi
		fi
	fi
	
	if [ ${mounted} -ne 0 ]; then
		chmod 777 ${DOWNLOADS_DIR}	
	fi
