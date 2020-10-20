	local board_name=$(board_name)
	board_name=${board_name/,/_}

	apalis_mount_boot
	get_image "$1" | tar Oxf - sysupgrade-${board_name}/kernel > /boot/uImage
	get_image "$1" | tar Oxf - sysupgrade-${board_name}/root > $(rootpart_from_uuid)
	sync
	umount /boot
