	local board=$(ipq806x_board_name)

	case "$board" in
	nbg6817)
		zyxel_do_upgrade "$1"
		;;
	esac
