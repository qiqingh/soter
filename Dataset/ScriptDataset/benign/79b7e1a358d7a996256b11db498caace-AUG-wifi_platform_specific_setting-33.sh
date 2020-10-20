	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		WL0_GUEST_IFNAME=`syscfg get wl0_guest_vap`
		WL0_GUEST_MAC=`syscfg get "$WL_SYSCFG".1_mac_addr`
		ifconfig $PHY_IF down
		wl -i $WL0_GUEST_IFNAME down
		wl -i $WL0_GUEST_IFNAME cur_etheraddr $WL0_GUEST_MAC
		ifconfig $WL0_GUEST_IFNAME down
		ifconfig $WL0_GUEST_IFNAME hw ether $WL0_GUEST_MAC
		ulog wlan status "Guest VAP interface $WL0_GUEST_IFNAME is enabled with MAC Address $WL0_GUEST_MAC"
		ifconfig $PHY_IF up
	fi
	if [ "$WL_SYSCFG" = "wl1" ]; then
		WL1_GUEST_IFNAME=`syscfg get wl1_guest_vap`
		WL1_GUEST_MAC=`syscfg get "$WL_SYSCFG".1_mac_addr`
		ifconfig $PHY_IF down
		wl -i $WL1_GUEST_IFNAME down
		wl -i $WL1_GUEST_IFNAME cur_etheraddr $WL1_GUEST_MAC
		ifconfig $WL1_GUEST_IFNAME down
		ifconfig $WL1_GUEST_IFNAME hw ether $WL1_GUEST_MAC
		ulog wlan status "Guest VAP interface $WL1_GUEST_IFNAME is enabled with MAC Address $WL1_GUEST_MAC"
		ifconfig $PHY_IF up
	fi
