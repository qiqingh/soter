	local board=$(board_name)

	case "$board" in
	mikrotik,routerboard-493g|\
	mikrotik,routerboard-922uags-5hpacd)
		platform_do_upgrade_mikrotik_nand "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
