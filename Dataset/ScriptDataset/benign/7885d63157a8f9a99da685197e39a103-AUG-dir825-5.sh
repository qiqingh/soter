	local magic="$(get_magic_long "$1")"
	local fw_mtd=$(find_mtd_part "firmware_orig")

	case "$magic" in
	"27051956")
		;;
	"43493030")
		local md5_img=$(dd if="$1" bs=2 skip=9 count=16 2>/dev/null)
		local md5_chk=$(dd if="$1" bs=64k skip=1 2>/dev/null | md5sum -); md5_chk="${md5_chk%% *}"
		local fw_len=$(dd if="$1" bs=2 skip=1 count=4 2>/dev/null)
		local fw_part_len=$(mtd_get_part_size "firmware")

		if [ -z "$fw_mtd" ]; then
			ask_bool 0 "Do you have a backup of the caldata partition?" || {
				echo "Warning, please make sure that you have a backup of the caldata partition."
				echo "Once you have that, use 'sysupgrade -i' for upgrading to the 'fat' firmware."
				return 1
			}
		fi

		if [ -z "$md5_img" -o -z "$md5_chk" ]; then
			echo "Unable to get image checksums. Maybe you are using a streamed image?"
			return 1
		fi

		if [ "$md5_img" != "$md5_chk" ]; then
			echo "Invalid image. Contents do not match checksum (image:$md5_img calculated:$md5_chk)"
			return 1
		fi

		fw_len=$((0x$fw_len))
		fw_part_len=${fw_part_len:-0}

		if [ $fw_part_len -lt $fw_len ]; then
			echo "The upgrade image is too big (size:$fw_len available:$fw_part_len)"
			return 1
		fi
		;;
	*)
		echo "Unsupported image format."
		return 1
		;;
	esac

	return 0
