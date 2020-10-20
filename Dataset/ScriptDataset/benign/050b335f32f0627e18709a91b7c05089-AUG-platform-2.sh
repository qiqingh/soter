	local board=$(lantiq_board_name)

	case "$board" in
	BTHOMEHUBV2B|BTHOMEHUBV3A|BTHOMEHUBV5A|P2812HNUF* )
		nand_do_upgrade $1
		;;
	esac
