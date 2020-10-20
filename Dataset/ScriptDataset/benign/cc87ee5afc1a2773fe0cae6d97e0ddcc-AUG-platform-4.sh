	local board=$(mpc85xx_board_name)
	local magic="$(get_magic_long "$1")"

	[ "$#" -gt 1 ] && return 1

	case $board in
	tl-wdr4900-v1)
		[ "$magic" != "01000000" ] && {
			echo "Invalid image type."
			return 1
		}

		local hwid
		local imageid

		hwid=$(tplink_get_hwid)
		imageid=$(tplink_get_image_hwid "$1")

		[ "$hwid" != "$imageid" ] && {
			echo "Invalid image, hardware ID mismatch, hw:$hwid image:$imageid."
			return 1
		}

		local boot_size

		boot_size=$(tplink_get_image_boot_size "$1")
		[ "$boot_size" != "00000000" ] && {
			echo "Invalid image, it contains a bootloader."
			return 1
		}

		return 0
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
