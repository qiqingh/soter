	case "$(board_name)" in
	8dev,jalapeno |\
	alfa-network,ap120c-ac |\
	avm,fritzbox-7530 |\
	avm,fritzrepeater-3000 |\
	qxwlan,e2600ac-c2)
		nand_do_upgrade "$1"
		;;
	asus,map-ac2200)
		CI_KERNPART="linux"
		nand_do_upgrade "$1"
		;;
	asus,rt-ac58u)
		CI_UBIPART="UBI_DEV"
		CI_KERNPART="linux"
		nand_do_upgrade "$1"
		;;
	linksys,ea6350v3 |\
	linksys,ea8300)
		platform_do_upgrade_linksys "$1"
		;;
	meraki,mr33)
		CI_KERNPART="part.safe"
		nand_do_upgrade "$1"
		;;
	openmesh,a42 |\
	openmesh,a62)
		PART_NAME="inactive"
		platform_do_upgrade_openmesh "$1"
		;;
	zyxel,nbg6617)
		zyxel_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
