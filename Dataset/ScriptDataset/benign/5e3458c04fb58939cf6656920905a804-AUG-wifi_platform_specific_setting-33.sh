	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		GUEST_IFNAME=`syscfg get wl0_guest_vap`
		GUEST_MAC=`syscfg get "$WL_SYSCFG".1_mac_addr`
		ifconfig $PHY_IF down
		wl -i $GUEST_IFNAME down
		wl -i $GUEST_IFNAME cur_etheraddr $GUEST_MAC
		ifconfig $GUEST_IFNAME down
		ifconfig $GUEST_IFNAME hw ether $GUEST_MAC
		ulog wlan status "Guest VAP interface $GUEST_IFNAME is enabled with MAC Address $GUEST_MAC"
		ifconfig $PHY_IF up
	fi
