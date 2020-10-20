	case "$(board_name)" in
		comtrend,vg-8050|\
		comtrend,vr-3032u|\
		huawei,hg253s-v2|\
		netgear,dgnd3700-v2)
			REQUIRE_IMAGE_METADATA=1
			cfe_jffs2_upgrade_tar "$1"
			;;
		sercomm,ad1018|\
		sercomm,h500-s-lowi|\
		sercomm,h500-s-vfes)
			REQUIRE_IMAGE_METADATA=1
			nand_do_upgrade "$1"
			;;
		*)
			default_do_upgrade "$1"
			;;
	esac
