	local board=$(ramips_board_name)

	case "$board" in
    	ubnt-erx)
		nand_do_upgrade "$ARGV"
		;;
	esac
