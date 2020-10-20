	local board=$(board_name)

	case "$board" in
	dlink,dir-685)
		return 0
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
