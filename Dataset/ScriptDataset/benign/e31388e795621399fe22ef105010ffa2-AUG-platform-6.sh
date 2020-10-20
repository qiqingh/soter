	local board=$(board_name)

	v "board=$board"
	case "$board" in
	avila | cambria )
		platform_do_upgrade_combined "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
