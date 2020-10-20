	local board=$(board_name)

	case "$board" in
	hc5962|\
	r6220|\
	netgear,r6350|\
	ubnt-erx|\
	ubnt-erx-sfp|\
	xiaomi,mir3g|\
	xiaomi,mir3p)
		nand_do_upgrade "$1"
		;;
	tplink,c50-v4)
		MTD_ARGS="-t romfile"
		default_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
