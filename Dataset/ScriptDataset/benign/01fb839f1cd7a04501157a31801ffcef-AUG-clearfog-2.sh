	sync
	get_image "$1" | dd of=/dev/mmcblk0 bs=2M conv=fsync
	sleep 1
