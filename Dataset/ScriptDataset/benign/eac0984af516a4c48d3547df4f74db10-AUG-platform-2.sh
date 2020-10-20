	local board=$(mvebu_board_name)

	case "$board" in
	armada-385-linksys-caiman|armada-385-linksys-cobra|armada-385-linksys-rango|armada-385-linksys-shelby|armada-xp-linksys-mamba)
		platform_do_upgrade_linksys "$ARGV"
		;;
	armada-388-clearfog)
		platform_do_upgrade_clearfog "$ARGV"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
