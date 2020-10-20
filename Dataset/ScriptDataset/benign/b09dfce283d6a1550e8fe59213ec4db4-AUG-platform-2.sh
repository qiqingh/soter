	local board=$(board_name)

	case "$board" in
	bt,homehub-v2b|\
	bt,homehub-v3a)
		nand_do_upgrade $1
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
