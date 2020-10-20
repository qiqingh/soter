	local magic="$(cybertan_get_image_magic "$1")"
	local fw_magic="$(cybertan_get_hw_magic)"

	[ "$fw_magic" != "$magic" ] && {
		echo "Invalid image, ID mismatch, got:$magic, but need:$fw_magic"
		return 1
	}

	return 0
