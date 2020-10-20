	case "$(board_name)" in
	8dev,jalapeno)
		nand_do_upgrade "$ARGV"
		;;
	asus,rt-ac58u)
		CI_UBIPART="UBI_DEV"
		CI_KERNPART="linux"
		nand_do_upgrade "$1"
		;;
	openmesh,a42 |\
	openmesh,a62)
		PART_NAME="inactive"
		platform_do_upgrade_openmesh "$ARGV"
		;;
	meraki,mr33)
		CI_KERNPART="part.safe"
		nand_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
