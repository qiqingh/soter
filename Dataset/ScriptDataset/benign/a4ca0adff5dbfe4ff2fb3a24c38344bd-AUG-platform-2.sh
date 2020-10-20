	local board=$(ramips_board_name)

	case "$board" in
	ubnt-erx)
		platform_upgrade_ubnt_erx "$ARGV"
		;;
	esac
