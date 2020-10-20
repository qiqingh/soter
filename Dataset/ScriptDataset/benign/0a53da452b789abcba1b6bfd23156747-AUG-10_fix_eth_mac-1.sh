	case $(board_name) in
	zyxel,nbg6716)
		ethaddr=$(mtd_get_mac_ascii u-boot-env ethaddr)
		ip link set dev eth0 address $(macaddr_add $ethaddr 2)
		ip link set dev eth1 address $(macaddr_add $ethaddr 3)
		;;
	esac
