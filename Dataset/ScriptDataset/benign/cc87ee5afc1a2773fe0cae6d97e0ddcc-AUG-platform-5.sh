	local board=$(mpc85xx_board_name)

	case "$board" in
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
