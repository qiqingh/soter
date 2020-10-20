	[ "$#" -gt 1 ] && return 1

	case "$(board_name)" in
		comtrend,vg-8050|\
		comtrend,vr-3032u|\
		huawei,hg253s-v2|\
		netgear,dgnd3700-v2|\
		sercomm,ad1018|\
		sercomm,h500-s-lowi|\
		sercomm,h500-s-vfes)
			# NAND sysupgrade
			return 0
			;;
	esac

	case "$(get_magic_word "$1")" in
		3600|3700|3800)
			# CFE tag versions
			return 0
			;;
		*)
			echo "Invalid image type. Please use only .bin files"
			return 1
			;;
	esac
