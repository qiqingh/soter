	local board=$(ar71xx_board_name)

	case "$board" in
	c-60|\
	nbg6716|\
	r6100|\
	wndr3700v4|\
	wndr4300)
		nand_do_upgrade "$1"
		;;
	mr18|\
	z1)
		merakinand_do_upgrade "$1"
		;;
	esac
