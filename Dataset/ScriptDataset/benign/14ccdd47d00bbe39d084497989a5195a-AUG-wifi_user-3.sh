	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		USER_VAP=`syscfg get "${WL_SYSCFG}"_user_vap`
		if [ -z "$USER_VAP" ]; then
			continue
		fi
		bring_vir_if_down ${PHY_IF} 0
		bring_phy_if_down $USER_VAP
		LAN_IFNAME=`syscfg get lan_ifname`
		delete_interface_from_bridge $USER_VAP $LAN_IFNAME
		ulog wlan status "${SERVICE_NAME}, user vap $USER_VAP is down"
		echo "${SERVICE_NAME}, user vap $USER_VAP is down"
	done
	return 0
