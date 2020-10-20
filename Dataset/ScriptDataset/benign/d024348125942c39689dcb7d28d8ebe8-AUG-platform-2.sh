	local board=$(board_name)

	case "$board" in
	traverse,ls1043v | \
	traverse,ls1043s)
		nand_do_platform_check "traverse-ls1043" $1
		return $?
		;;
	fsl,ls1012a-frdm)
		return 0
		;;
	*)
		echo "Sysupgrade is not currently supported on $board"
		;;
	esac

	return 1
