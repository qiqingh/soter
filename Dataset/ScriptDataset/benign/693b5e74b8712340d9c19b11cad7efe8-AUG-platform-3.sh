	local board=$(board_name)

	case "$board" in
	traverse,ls1043v | \
	traverse,ls1043s)
		platform_do_upgrade_traverse_nandubi "$ARGV"
		;;
	*)
		echo "Sysupgrade is not currently supported on $board"
		;;
	esac
