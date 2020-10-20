	local board=$(board_name)

	case "$board" in
	dlink,dir-685)
		PART_NAME=firmware
		default_do_upgrade "$1"
		;;
	esac
