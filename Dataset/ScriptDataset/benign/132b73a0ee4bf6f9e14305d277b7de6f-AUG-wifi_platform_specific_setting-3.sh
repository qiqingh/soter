	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	MBSS_ENABLED=`wl -i $PHY_IF mbss`
	if [ "${MBSS_ENABLED}" = "0" ]; then 
		wl -i ${PHY_IF} mbss 1
		wl -i ${PHY_IF} ssid -C $MBSS_PRIMARY "" > /dev/null
		wl -i ${PHY_IF} ssid -C $MBSS_GUEST "" > /dev/null
		if [ ${WL_SYSCFG} = "wl0" ] && [ "1" = "`syscfg get tc_vap_enabled`" ]; then
			wl -i ${PHY_IF} ssid -C $MBSS_SIMPLETAP "" > /dev/null
		fi
		set_driver_guest_mac ${PHY_IF}
		if [ ${WL_SYSCFG} = "wl0" ] && [ "1" = "`syscfg get tc_vap_enabled`" ]; then
			set_driver_tc_mac ${PHY_IF}	
		fi
		ulog wlan status "${SERVICE_NAME}, enable mbss: $PHY_IF"	
	else
		ulog wlan status "${SERVICE_NAME}, Warning: can not add mbss to $PHY_IF, mbss already existed"
		return 1
	fi
	return 0
