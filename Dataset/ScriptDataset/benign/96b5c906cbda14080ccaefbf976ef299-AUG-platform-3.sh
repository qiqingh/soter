	local board=$(board_name)

	case "$board" in
	ubnt-erx|\
	ubnt-erx-sfp)
		platform_upgrade_ubnt_erx "$ARGV"
		;;
	esac
