	case "$(board_name)" in
	armada-385-linksys-caiman|armada-385-linksys-cobra|armada-385-linksys-rango|armada-385-linksys-shelby|armada-385-linksys-venom|armada-xp-linksys-mamba)
		platform_copy_config_linksys
		;;
	armada-385-turris-omnia|armada-388-clearfog-base|armada-388-clearfog-pro|globalscale,espressobin|marvell,armada8040-mcbin)
		platform_copy_config_sdcard "$ARGV"
		;;
	esac
