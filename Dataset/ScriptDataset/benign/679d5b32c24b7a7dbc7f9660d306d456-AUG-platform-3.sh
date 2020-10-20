	apalis_mount_boot
	get_image "$1" | tar Oxf - sysupgrade-apalis/kernel > /boot/uImage
	get_image "$1" | tar Oxf - sysupgrade-apalis/root > $(rootpart_from_uuid)
	sync
	umount /boot
