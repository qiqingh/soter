	PHY_IF=`syscfg get wl0_physical_ifname`
	USER_VAP=`syscfg get wl0_user_vap`
	WL_SYSCFG=`get_syscfg_interface_name $USER_VAP`
	GUEST_VAP=`syscfg get ${WL_SYSCFG}_guest_vap`
	if [ "started" != "`sysevent get ${WIFI_USER}-status`" ] ; then
		ulog wlan status "${SERVICE_NAME}, user vap is not started, do not start wifi guest"
		return 1
	fi
	REPEATER_DISABLED=`syscfg get repeater_disabled`
	if [ -n "$REPEATER_DISABLED" ] && [ "1" = "$REPEATER_DISABLED" ]; then
		ulog wlan status "${SERVICE_NAME}, Repeater disabled. service not start"
		sysevent set ${GUEST}-errinfo "Repeater disabled. service not started"
		return 1
	fi
	if [ ! -z "$SYSCFG_extender_radio_mode" -a "1" = "$SYSCFG_extender_radio_mode" ] ; then
		echo "Guest LAN is not supported on 5GHz wifi Extender" > /dev/console
		return 1
	fi
	USER_VAP_STATE=`syscfg get "${WL_SYSCFG}"_state`
	if [ "down" = "${USER_VAP_STATE}" ] ; then	
		ulog wlan status "${SERVICE_NAME}, user vap state is down, do not start wifi guest"
		return 1
	fi
	USER_VAP_DISABLED=`syscfg get "${WL_SYSCFG}"_uvap_disabled`
	if [ -n "$USER_VAP_DISABLED" ] && [ "1" = "$USER_VAP_DISABLED" ] ; then
		ulog wlan status "${SERVICE_NAME}, user vap is disabled, do not start wifi guest" > /dev/console
		return 1
	fi
	if [ -z $USER_VAP ]; then
		ulog wlan status "${SERVICE_NAME}, user vap name is invalid, , do not start wifi guest" > /dev/console
		return 1
	fi
	if [ -z $GUEST_VAP ]; then
		ulog wlan status "${SERVICE_NAME}, guest vap is empty, do not start wifi guest"
		return 1
	fi
	GUEST_SSID=`syscfg get guest_ssid`
	if [ -z "$GUEST_SSID" ]; then 
		ulog wlan status "${SERVICE_NAME}, guest ssid is empty, do not start wifi guest"
		return 1
	fi
	GUEST_ENABLED=`syscfg get guest_enabled`
	if [ "$GUEST_ENABLED" != "1" ]; then
		echo "${SERVICE_NAME}, guest_enabled is set to 0, do not enable 2.4GHz guest"
		ulog wlan status "${SERVICE_NAME}, guest_enabled is set to 0, do not enable 2.4GHz guest"
		return 1
	fi
	WL0_GUEST_ENABLED=`syscfg get wl0_guest_enabled`
	if [ "$WL0_GUEST_ENABLED" = "1" ]; then
		is_mbss_enabled ${PHY_IF}
		if [ "$?" = "0" ]; then
			echo "${SERVICE_NAME}, enabling MBSS on 2.4GHz requires a wifi-restart"
			ulog wlan status "${SERVICE_NAME}, enabling MBSS on 2.4GHz requires a wifi-restart"
			sysevent set wifi-restart
			return 1
		fi
	else
		echo "${SERVICE_NAME}, guest 2.4GHz is not enabled"
		ulog wlan status "${SERVICE_NAME}, guest 2.4GHz is not enabled"
		return 1
	fi
	configure_guest $PHY_IF
	GUEST_BRIDGE=`syscfg get guest_lan_ifname`
	add_interface_to_bridge $GUEST_VAP $GUEST_BRIDGE
	bring_phy_if_up $GUEST_VAP
	bring_vir_if_up $USER_VAP 1
	sysevent set ${WL_SYSCFG}_guest_status "up"
	ulog wlan status "${SERVICE_NAME}, Wi-Fi Guest 2.4GHz is up"
	echo "${SERVICE_NAME}, Wi-Fi Guest 2.4GHz is up " > /dev/console
	return 0