	MFG_MODE=$(gcontrol uenv get ManufactureMode | awk -F"=" '{print $2}')
	[ $MFG_MODE = "1" ] && {
		echo "======================================================" > /dev/console
		echo "================Starting Manufcture Mode==============" > /dev/console
		echo "======================================================" > /dev/console
		uci set network.wan.disabled='1'
		uci set network.wan6.disabled='1'
		uci set network.lan.ifname="eth0 eth1"
		uci set network.lan.proto='static'
		uci set network.lan.ipaddr="192.168.1.1"
		uci set network.lan.netmask="255.255.255.0"
		uci set network.lan.gateway="192.168.1.123"
		uci commit network
	}
	[ $MFG_MODE = "2" ] && {
                echo "======================================================" > /dev/console
		echo "================Starting Golden Mode==================" > /dev/console
		echo "======================================================" > /dev/console
		log_info "Starting Golden Mode"
		uci set network.wan.disabled='1'
		uci set network.wan6.disabled='1'
		uci set network.lan.ifname="eth0 eth1"
		uci set network.lan.proto='static'
		uci set network.lan.ipaddr="192.168.1.123"
		uci set network.lan.netmask="255.255.255.0"
		uci set network.lan.gateway="192.168.1.1"
		uci commit network
	}
