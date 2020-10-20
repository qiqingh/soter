	if type 'platform_nand_board_name' >/dev/null 2>/dev/null; then
		platform_nand_board_name
		return
	fi

	cat /tmp/sysinfo/board_name
