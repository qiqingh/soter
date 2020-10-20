	mkdir -p /recovery
	mount -o rw,noatime /dev/mmcblk0p1 /recovery
	cp -af "$UPGRADE_BACKUP" "/recovery/$BACKUP_FILE"
	sync
	umount /recovery
