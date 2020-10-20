	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		TC_IFNAME=`syscfg get tc_vap_user_vap`
		TC_MAC=`syscfg get "$WL_SYSCFG".2_mac_addr`
		ifconfig $PHY_IF down
		wl -i $TC_IFNAME down
		wl -i $TC_IFNAME cur_etheraddr $TC_MAC
		ifconfig $TC_IFNAME down
		ifconfig $TC_IFNAME hw ether $TC_MAC
		ulog wlan status "T&C VAP interface $TC_IFNAME is enabled with MAC Address $TC_MAC"
		ifconfig $PHY_IF up
	fi
