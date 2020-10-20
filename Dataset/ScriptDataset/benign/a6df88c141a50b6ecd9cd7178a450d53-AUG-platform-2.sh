	case "$(board_name)" in
	buffalo,wxr-2533dhp)
		buffalo_upgrade_prepare_ubi
		CI_ROOTPART="ubi_rootfs"
		nand_do_upgrade "$1"
		;;
	compex,wpq864|\
	netgear,d7800 |\
	netgear,r7500 |\
	netgear,r7500v2 |\
	netgear,r7800 |\
	qcom,ipq8064-ap148 |\
	qcom,ipq8064-ap161 |\
	zyxel,nbg6817)
		nand_do_upgrade "$1"
		;;
	linksys,ea8500)
		platform_do_upgrade_linksys "$1"
		;;
	tplink,c2600)
		PART_NAME="os-image:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$1"
		;;
	tplink,vr2600v)
		PART_NAME="kernel:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$1"
		;;
	nec,wg2600hp |\
	*)
		default_do_upgrade "$1"
		;;
	esac