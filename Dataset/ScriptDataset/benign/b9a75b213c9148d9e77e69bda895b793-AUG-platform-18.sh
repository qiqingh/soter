	local board=$(ar71xx_board_name)

	case "$board" in
	rb*)
		CI_KERNPART=none
		local fw_mtd=$(find_mtd_part kernel)
		fw_mtd="${fw_mtd/block/}"
		[ -n "$fw_mtd" ] || return
		mtd erase kernel
		tar xf "$1" sysupgrade-routerboard/kernel -O | nandwrite -o "$fw_mtd" -
		;;
	esac
