	case "$(board_name)" in
	asus,rt-ac58u)
		CI_UBIPART="UBI_DEV"
		CI_KERNPART="linux"
		;;
	meraki,mr33)
		CI_KERNPART="part.safe"
		;;
	esac
