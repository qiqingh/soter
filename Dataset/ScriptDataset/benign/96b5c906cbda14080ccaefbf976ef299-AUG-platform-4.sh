	local board=$(board_name)

	case "$board" in
	hc5962|\
	mir3g|\
	r6220|\
	ubnt-erx|\
	ubnt-erx-sfp)
		nand_do_upgrade "$ARGV"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
