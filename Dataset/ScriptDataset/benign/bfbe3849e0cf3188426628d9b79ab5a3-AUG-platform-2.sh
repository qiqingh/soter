	case "$(board_name)" in
	linksys,caiman|linksys,cobra|linksys,mamba|linksys,rango|linksys,shelby|linksys,venom)
		platform_do_upgrade_linksys "$1"
		;;
	cznic,turris-omnia|globalscale,espressobin|globalscale,espressobin-emmc|globalscale,espressobin-v7|globalscale,espressobin-v7-emmc|\
	marvell,armada8040-mcbin|solidrun,clearfog-base-a1|solidrun,clearfog-pro-a1)
		platform_do_upgrade_sdcard "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
