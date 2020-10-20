	case $(board_name) in
	meraki,mr33)
		mac_lan=$(get_mac_binary "/sys/bus/i2c/devices/0-0050/eeprom" 102)
		[ -n "$mac_lan" ] && ip link set dev eth0 address "$mac_lan"
		;;
	esac
