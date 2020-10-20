	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, wifi_up($PHY_IF)"
	wifi_physical_start $PHY_IF
	if [ "$?" = "0" ]; then
		wl0_ifname=`syscfg_get wl0_physical_ifname`
		wl1_ifname=`syscfg_get wl1_physical_ifname`
		if [ $PHY_IF = $wl1_ifname ]; then
			SYSCFG_INDEX=`syscfg_get "$wl0_ifname"_syscfg_index`
			USER_STATE=`syscfg_get ${SYSCFG_INDEX}_state`
			if [ "$USER_STATE" = "down" ]; then
				ifconfig $wl0_ifname up
				only_5g=1
			fi
		fi
		wifi_virtual_start $PHY_IF
		if [ "$?" = "0" ]; then
			WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
			VIR_IF=`syscfg_get "$WL_SYSCFG"_user_vap`
			LAN_IFNAME=`syscfg_get lan_ifname`
			add_interface_to_bridge $VIR_IF $LAN_IFNAME
			echo "${SERVICE_NAME}, $VIR_IF is up"		
		fi
		wifi_guest_start $PHY_IF
		if [ "$?" = "0" ]; then
			INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
			GUEST_VAP=`syscfg_get "$INDEX"_guest_vap`
			GUEST_BRIDGE=`syscfg_get guest_lan_ifname`
			add_interface_to_bridge $GUEST_VAP $GUEST_BRIDGE
			ulog guest status "guest $GUEST_VAP is up"
			echo "${SERVICE_NAME}, guest $GUEST_VAP is up " > /dev/console
		fi
	fi
	if [ "$only_5g" = "1" ]; then
		ifconfig $wl0_ifname down
	fi
	start_radius_ea7300 $PHY_IF
