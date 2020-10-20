	TC="tc_vap"
	PHY_IF=`syscfg get wl0_physical_ifname`
	WL_SYSCFG=`get_syscfg_interface_name ${PHY_IF}`
	TC_VAP=`syscfg get ${TC}_user_vap`
	USER_VAP=`syscfg get wl0_user_vap`
	if [ -z $TC_VAP ]; then
		ulog wlan status "${SERVICE_NAME}, ${TC} name is not defined, do not start tap & connect"
		return 1
	fi
	PID=`ps | grep -e eapd -e nas | awk "/$TC_VAP/"' {print $1}'`
	if [ ! -z "$PID" ] ; then
		kill $PID > /dev/null 2>&1
		DEBUG ulog wlan status "Stopped 1x Authentication agent on $TC_VAP"
	fi
	sysevent set ${WIFI_SIMPLETAP}-status stopping
	bring_vir_if_down $PHY_IF 2
	BRIDGE=`syscfg get ${TC}_lan_ifname`
	delete_interface_from_bridge $TC_VAP $BRIDGE
	is_mbss_needed ${PHY_IF}
	if [ "$?" = "0" ]; then 
		is_mbss_enabled ${PHY_IF}
		if [ "$?" = "1" ]; then
			echo "${SERVICE_NAME}, disabling MBSS, wifi restart is required"
			sysevent set wifi-restart
		fi
	fi
	echo "${SERVICE_NAME}, Tap Connect is down"
	sysevent set ${TC}_state "down"
	ulog wlan status "${SERVICE_NAME}, Tap Connect is down"
	return 0
