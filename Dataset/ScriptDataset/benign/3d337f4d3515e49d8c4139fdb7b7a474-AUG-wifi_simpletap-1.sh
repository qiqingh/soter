	PHY_IF=`syscfg get wl0_physical_ifname`
	TC="tc_vap"
	TC_VAP=`syscfg get ${TC}_user_vap`
	USER_VAP=`syscfg get wl0_user_vap`
	if [ "started" != "`sysevent get ${WIFI_USER}-status`" ] ; then
		ulog wlan status "${SERVICE_NAME}, user vap is not started, do not start wifi guest"
		return 1
	fi
	if [ "down" = "`syscfg get wl0_state`" ] ; then	
		ulog wlan status "${SERVICE_NAME}, user vap state is down, do not start tap & connect"
		return 1
	fi
	UVAP_DISABLED=`syscfg get wl0_uvap_disabled`
	if [ -n "$UVAP_DISABLED" ] && [ "1" = "$UVAP_DISABLED" ] ; then
		ulog wlan status "${SERVICE_NAME}, user vap is disabled, do not start tap & connect"
		return 1
	fi
	if [ -z $TC_VAP ]; then
		ulog wlan status "${SERVICE_NAME}, tc_vap name is not defined, do not start tap & connect"
		return 1
	fi
	TC_VAP_SSID=`syscfg get ${TC}_ssid`
	if [ -z $TC_VAP_SSID ]; then 
		ulog wlan status "${SERVICE_NAME}, tc_vap ssid is not defined, do not start tap & connect"
		return 1
	fi
	TC_ENABLED=`syscfg get ${TC}_enabled`
	if [ "$TC_ENABLED" = "1" ]; then
		is_mbss_enabled ${PHY_IF}
		if [ "$?" = "0" ]; then
			echo "${SERVICE_NAME}, enabling MBSS requires a wifi-restart"
			sysevent set wifi-restart
			return 1
		else
			bring_vir_if_up ${PHY_IF} 2
		fi
	else
		return 1
	fi
	configure_simpletap $TC_VAP
	BRIDGE=`syscfg get ${TC}_lan_ifname`
	add_interface_to_bridge $TC_VAP $BRIDGE
	bring_phy_if_up $TC_VAP
	sysevent set ${TC}_state "up"
	echo "${SERVICE_NAME}, Tap Connect is up"
	
	ulog wlan status "${SERVICE_NAME}, Tap Connect is up"
	return 0
