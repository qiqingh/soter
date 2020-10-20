	for PHY_IF in $PHYSICAL_IF_LIST; do
		bring_vir_if_down ${PHY_IF} 0
		bring_phy_if_down ${PHY_IF}
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		USER_VAP=`syscfg get "${WL_SYSCFG}"_user_vap`
		USER_VAP_STATE=`syscfg get ${WL_SYSCFG}_state`
		if [ "down" = "$USER_VAP_STATE" ]; then
			ulog wlan status "${SERVICE_NAME}, $USER_VAP is disable"
			continue
		fi
		if [ -z "$USER_VAP" ]; then
			ulog wlan status "${SERVICE_NAME}, something wrong, user vap name is empty"
			continue
		fi
		USER_SSID=`syscfg get "${WL_SYSCFG}"_ssid`
		if [ -z "$USER_SSID" ]; then 
			DEBUG wlan status "User VAP ssid  $WL_SYSCFG is empty"
			continue
		fi
		configure_user $USER_VAP
		set_driver_extra_virtual_settings $USER_VAP
		LAN_IFNAME=`syscfg get lan_ifname`
		add_interface_to_bridge $USER_VAP $LAN_IFNAME
	done
	return 0
