	CI_KERNPART=none

	local fw_mtd=$(find_mtd_part kernel)
	fw_mtd="${fw_mtd/block/}"
	[ -n "$fw_mtd" ] || return

	local board_dir=$(tar tf "$1" | grep -m 1 '^sysupgrade-.*/$')
	board_dir=${board_dir%/}
	[ -n "$board_dir" ] || return

	mtd erase kernel
	tar xf "$1" ${board_dir}/kernel -O | nandwrite -o "$fw_mtd" -

	nand_do_upgrade "$1"
