	local board=$(board_name)

	case "$board" in
	mikrotik,rbm33g)
		[ -z "$(rootfs_type)" ] && mtd erase firmware
		;;
	esac
