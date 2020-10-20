	case "$(board_name)" in
	linksys,caiman|linksys,cobra|linksys,mamba|linksys,rango|linksys,shelby|linksys,venom)
		platform_copy_config_linksys
		;;
	cznic,turris-omnia|globalscale,espressobin|globalscale,espressobin-emmc|globalscale,espressobin-v7|globalscale,espressobin-v7-emmc|\
	marvell,armada8040-mcbin|solidrun,clearfog-base-a1|solidrun,clearfog-pro-a1)
		platform_copy_config_sdcard
		;;
	esac
