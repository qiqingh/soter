	local board=$(board_name)

	case "$board" in
	jjplus,ja76pf2)
		redboot_fis_do_upgrade "$1" linux
		;;
	ubnt,routerstation|\
	ubnt,routerstation-pro)
		redboot_fis_do_upgrade "$1" kernel
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
