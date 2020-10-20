	local board=$(board_name)

	case "$board" in
	glinet,gl-ar300m-nand|\
	glinet,gl-ar300m-nor)
		glinet_nand_nor_do_upgrade "$1"
		;;
	glinet,gl-ar750s-nor|\
	glinet,gl-ar750s-nor-nand)
		nand_nor_do_upgrade "$1"
		;;
	*)
		nand_do_upgrade "$1"
		;;
	esac
