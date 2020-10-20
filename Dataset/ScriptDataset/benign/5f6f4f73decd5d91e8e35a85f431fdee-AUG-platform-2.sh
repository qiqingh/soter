	case "$(board_name)" in
	compex,wpq864|\
	netgear,d7800 |\
	netgear,r7500 |\
	netgear,r7500v2 |\
	netgear,r7800 |\
	qcom,ipq8064-ap148 |\
	zyxel,nbg6817)
		nand_do_upgrade "$ARGV"
		;;
	linksys,ea8500)
		platform_do_upgrade_linksys "$ARGV"
		;;
	tplink,c2600)
		PART_NAME="os-image:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$ARGV"
		;;
	tplink,vr2600v)
		PART_NAME="kernel:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$ARGV"
		;;
	nec,wg2600hp |\
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
