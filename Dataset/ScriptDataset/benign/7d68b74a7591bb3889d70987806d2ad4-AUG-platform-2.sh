	case "$(board_name)" in
	armada-385-linksys-caiman|armada-385-linksys-cobra|armada-385-linksys-rango|armada-385-linksys-shelby|armada-385-linksys-venom|armada-xp-linksys-mamba)
		platform_do_upgrade_linksys "$ARGV"
		;;
	armada-385-turris-omnia|armada-388-clearfog-base|armada-388-clearfog-pro|globalscale,espressobin|marvell,armada8040-mcbin)
		platform_do_upgrade_sdcard "$ARGV"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac