	local board=$(ipq806x_board_name)

	case "$board" in
	ap148 |\
	d7800 |\
	nbg6817 |\
	r7500 |\
	r7500v2 |\
	r7800)
		nand_do_upgrade "$1"
		;;
	ea8500)
		linksys_preupgrade "$1"
		;;
	esac
