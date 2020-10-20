	local partdev

	if export_partdevice partdev 1; then
		mkdir -p /boot
		[ -f /boot/kernel.img ] || mount -o rw,noatime /dev/$partdev /boot
		cp -af "$UPGRADE_BACKUP" "/boot/$BACKUP_FILE"
		sync
		umount /boot
	fi
