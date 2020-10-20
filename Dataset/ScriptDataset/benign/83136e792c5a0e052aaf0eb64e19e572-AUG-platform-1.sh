	case "$(board_name)" in
	cznic,turris-omnia|\
	kobol,helios4|\
	solidrun,clearfog-base-a1|\
	solidrun,clearfog-pro-a1)
		platform_check_image_sdcard "$1"
		;;
	*)
		return 0
		;;
	esac
