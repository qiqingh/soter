	WL0_PHY_IF=`syscfg_get wl0_physical_ifname`
	WL0_VIR_IF=`syscfg_get wl0_user_vap`
	WL0_MAC_CURRENT=`ifconfig ${WL0_PHY_IF} | grep HWaddr | awk '{print $5}'`
	WL0_MAC_NEW=`syscfg_get wl0_mac_addr`
	if [ ! -z "$WL0_MAC_NEW" ] && [ "$WL0_MAC_NEW" != "$WL0_MAC_CURRENT" ]; then
		WL0_MAC=`echo $WL0_MAC_NEW | tr -d :`
	fi
	WL1_PHY_IF=`syscfg_get wl1_physical_ifname`
	WL1_VIR_IF=`syscfg_get wl1_user_vap`
	WL1_MAC_CURRENT=`ifconfig ${WL1_PHY_IF} | grep HWaddr | awk '{print $5}'`
	WL1_MAC_NEW=`syscfg_get wl1_mac_addr`
	if [ ! -z "$WL1_MAC_NEW" ] && [ "$WL1_MAC_NEW" != "$WL1_MAC_CURRENT" ]; then
		WL1_MAC=`echo $WL1_MAC_NEW | tr -d :`
	fi
	WL0_PHY_IF=`syscfg get wl0_physical_ifname`
	set_driver_guest_mac ${WL0_PHY_IF}
	set_driver_tc_mac ${WL0_PHY_IF}
