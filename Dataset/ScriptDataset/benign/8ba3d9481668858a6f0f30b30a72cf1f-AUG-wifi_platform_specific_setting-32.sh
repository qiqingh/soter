	LAN_HWADDR=`ifconfig eth0 | grep HWaddr | awk '{print $5}'`
	LAN_MAC=`syscfg get lan_mac_addr`
	if [ ! -z "$LAN_MAC" ] && [ "$LAN_MAC" != "$LAN_HWADDR" ]; then
		ifconfig eth0 down
		ifconfig eth0 hw ether $LAN_MAC
		ifconfig eth0 up
	fi
	WL0_PHY_IF=`syscfg get wl0_physical_ifname`
	WL0_HWADDR=`ifconfig ${WL0_PHY_IF} | grep HWaddr | awk '{print $5}'`
	WL0_MAC=`syscfg get wl0_mac_addr`
	if [ ! -z "$WL0_MAC" ] && [ "$WL0_MAC" != "$WL0_HWADDR" ]; then
		ifconfig $WL0_PHY_IF down
		ifconfig $WL0_PHY_IF hw ether $WL0_MAC
		ifconfig $WL0_PHY_IF up
	fi
	WL1_PHY_IF=`syscfg get wl1_physical_ifname`
	WL1_HWADDR=`ifconfig ${WL1_PHY_IF} | grep HWaddr | awk '{print $5}'`
	WL1_MAC=`syscfg get wl1_mac_addr`
	if [ ! -z "$WL1_MAC" ] && [ "$WL1_MAC" != "$WL1_HWADDR" ]; then
		ifconfig $WL1_PHY_IF down
		ifconfig $WL1_PHY_IF hw ether $WL1_MAC
		ifconfig $WL1_PHY_IF up
	fi
