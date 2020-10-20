	case "$(board_name)" in
	cznic,turris-omnia|\
	kobol,helios4|\
	solidrun,clearfog-base-a1|\
	solidrun,clearfog-pro-a1)
		platform_copy_config_sdcard
		;;
	linksys,wrt1200ac|\
	linksys,wrt1900ac-v1|\
	linksys,wrt1900ac-v2|\
	linksys,wrt1900acs|\
	linksys,wrt3200acm|\
	linksys,wrt32x)
		platform_copy_config_linksys
		;;
	esac
