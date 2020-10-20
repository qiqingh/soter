	local board=$(board_name)

	case "$board" in
	*)
		default_do_upgrade "$1"
		;;
	esac
