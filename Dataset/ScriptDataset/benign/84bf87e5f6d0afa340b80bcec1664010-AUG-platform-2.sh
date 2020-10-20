	local board=$(board_name)

	case "$board" in
	ocedo,panda|\
	sophos,red-15w-rev1)
		nand_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
