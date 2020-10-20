	case "$(board_name)" in
	cznic,turris-omnia|globalscale,espressobin|globalscale,espressobin-emmc|globalscale,espressobin-v7|globalscale,espressobin-v7-emmc|\
	marvell,armada8040-mcbin|solidrun,clearfog-base-a1|solidrun,clearfog-pro-a1)
		platform_check_image_sdcard "$1"
		;;
	*)
		return 0
		;;
	esac
