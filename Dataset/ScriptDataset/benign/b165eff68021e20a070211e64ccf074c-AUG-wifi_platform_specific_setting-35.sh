	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ]; then
		WL0_TC_IFNAME=`syscfg get tc_vap_user_vap`
		WL0_TC_MAC=`syscfg get "$WL_SYSCFG".2_mac_addr`
		if [ ! -z "$WL0_TC_MAC" ]; then
			ifconfig $PHY_IF down
			wl -i $WL0_TC_IFNAME down
			wl -i $WL0_TC_IFNAME cur_etheraddr $WL0_TC_MAC
			ifconfig $WL0_TC_IFNAME down
			ifconfig $WL0_TC_IFNAME hw ether $WL0_TC_MAC
			ulog wlan status "T&C VAP interface $WL0_TC_IFNAME is enabled with MAC Address $WL0_TC_MAC"
			ifconfig $PHY_IF up
		fi
	fi
