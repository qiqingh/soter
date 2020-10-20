	local board=$(board_name)

	# Force the creation of fw_printenv.lock
	mkdir -p /var/lock
	touch /var/lock/fw_printenv.lock

	case "$board" in
	traverse,ls1043v | \
	traverse,ls1043s)
		platform_do_upgrade_traverse_nandubi "$1"
		;;
	fsl,ls1012a-frdm)
		PART_NAME=firmware
		default_do_upgrade "$1"
		;;
	*)
		echo "Sysupgrade is not currently supported on $board"
		;;
	esac
