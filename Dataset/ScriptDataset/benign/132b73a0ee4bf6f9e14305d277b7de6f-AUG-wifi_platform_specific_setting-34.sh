	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	GUEST_IFNAME=`syscfg get "$WL_SYSCFG"_guest_vap`
	GUEST_MAC=`syscfg get "$WL_SYSCFG".1_mac_addr`
	ifconfig $PHY_IF down
	wl -i $GUEST_IFNAME down
	wl -i $GUEST_IFNAME cur_etheraddr $GUEST_MAC
	ifconfig $GUEST_IFNAME down
	ifconfig $PHY_IF up
	ifconfig $GUEST_IFNAME hw ether $GUEST_MAC
	ulog wlan status "Guest VAP interface $GUEST_IFNAME is enabled with MAC Address $GUEST_MAC"
