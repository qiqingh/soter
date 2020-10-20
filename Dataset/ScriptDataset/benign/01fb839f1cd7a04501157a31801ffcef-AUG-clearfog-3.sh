	mkdir -p /boot
	[ -f /boot/kernel.img ] || mount -t vfat -o rw,noatime /dev/mmcblk0p1 /boot
	cp -af "$CONF_TAR" /boot/
	sync
	umount /boot
