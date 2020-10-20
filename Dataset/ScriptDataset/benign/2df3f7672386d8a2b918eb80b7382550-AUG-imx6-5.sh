	mkdir -p /boot
	[ -f /boot/uImage ] || {
		mount -o rw,noatime $(bootpart_from_uuid) /boot > /dev/null
	}
