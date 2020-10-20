	case "$(board_name)" in
	buffalo,ls421de)
		nand_do_upgrade "$1"
		;;
	cznic,turris-omnia|\
	kobol,helios4|\
	solidrun,clearfog-base-a1|\
	solidrun,clearfog-pro-a1)
		platform_do_upgrade_sdcard "$1"
		;;
	linksys,wrt1200ac|\
	linksys,wrt1900ac-v1|\
	linksys,wrt1900ac-v2|\
	linksys,wrt1900acs|\
	linksys,wrt3200acm|\
	linksys,wrt32x)
		platform_do_upgrade_linksys "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
