	local board=$(ixp4xx_board_name)

	v "board=$board"
	case "$board" in
	avila | cambria )
		platform_do_upgrade_combined "$ARGV"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
