	PHY_IF=$1
	RET_CODE="0"
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ ${WL_SYSCFG} = "wl0" ]; then
		GUEST_ENABLED=`syscfg get guest_enabled`
		TC_ENABLED=`syscfg get tc_vap_enabled`
		USER_VAP_STATE=`syscfg get ${WL_SYSCFG}_state`
		if [ "$USER_VAP_STATE" = "up" ]; then
			if [ "${GUEST_ENABLED}" = "1" ] || [ "${TC_ENABLED}" = "1" ]; then
				RET_CODE="1"
			fi
		fi
	fi
	if [ "2g" = "`syscfg get wifi_sta_radio`" ] && [ "1" = "`syscfg get wifi_sta_enabled`" ]; then
		ulog wlan status "${SERVICE_NAME}, PSTA mode, do not need MBSS"
		return "0"
	fi
	return ${RET_CODE}
