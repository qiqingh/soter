	[ -e /dev/ubi0 ] || {
		ubiattach -m 1
		sleep 1
	}
	return 0;
