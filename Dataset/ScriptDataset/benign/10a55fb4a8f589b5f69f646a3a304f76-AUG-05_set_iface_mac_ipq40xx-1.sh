	case $(board_name) in
	asus,map-ac2200)
		base_mac=$(mtd_get_mac_binary_ubi Factory 4102)
		ip link set dev eth0 address $(macaddr_add "$base_mac" +1)
		ip link set dev eth1 address $(macaddr_add "$base_mac" +3)
		;;
	linksys,ea8300)
		base_mac=$(mtd_get_mac_ascii devinfo hw_mac_addr)
		ip link set dev eth0 address "${base_mac}"
		ip link set dev eth1 address $(macaddr_add "${base_mac}" 1)
		;;
	meraki,mr33)
		mac_lan=$(get_mac_binary "/sys/bus/i2c/devices/0-0050/eeprom" 102)
		[ -n "$mac_lan" ] && ip link set dev eth0 address "$mac_lan"
		;;
	zyxel,nbg6617)
		base_mac=$(cat /sys/class/net/eth0/address)
		ip link set dev eth0 address $(macaddr_add "$base_mac" +2)
		ip link set dev eth1 address $(macaddr_add "$base_mac" +3)
	esac