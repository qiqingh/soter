	local magic_long="$(get_magic_long "$1")"
	local fw_part_size=$(mtd_get_part_size firmware)

	case "$magic_long" in
	"27051956")
		[ "$fw_part_size" != "16318464" ] && {
			echo "Invalid image magic \"$magic_long\" for $fw_part_size bytes"
			return 1
		}
		;;
	"68737173")
		[ "$fw_part_size" != "7929856" ] && {
			echo "Invalid image magic \"$magic_long\" for $fw_part_size bytes"
			return 1
		}
		;;
	esac

	return 0
