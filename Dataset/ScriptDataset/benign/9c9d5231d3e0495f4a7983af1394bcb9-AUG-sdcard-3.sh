	mkdir -p /boot
	[ -f /boot/kernel.img ] || mount -o rw,noatime /dev/mmcblk0p1 /boot
	cp -af "$CONF_TAR" /boot/
	sync
	umount /boot
