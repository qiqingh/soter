	PHY_IF=$1
	RET_CODE="0"
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	USER_VAP_STATE=`syscfg get ${WL_SYSCFG}_state`
	GUEST_ENABLED=`syscfg get guest_enabled`
	if [ ${WL_SYSCFG} = "wl0" ] && [ "$USER_VAP_STATE" = "up" ]; then
		WL0_GUEST_ENABLED=`syscfg get wl0_guest_enabled`
		if [ "${GUEST_ENABLED}" = "1" ] && [ "${WL0_GUEST_ENABLED}" = "1" ]; then
			RET_CODE="1"
		fi
		TC_ENABLED=`syscfg get tc_vap_enabled`
		if [ "${TC_ENABLED}" = "1" ]; then
			RET_CODE="1"
		fi
	fi
	if [ ${WL_SYSCFG} = "wl1" ] && [ "$USER_VAP_STATE" = "up" ]; then
		WL1_GUEST_ENABLED=`syscfg get wl1_guest_enabled`
		if [ "${GUEST_ENABLED}" = "1" ] && [ "${WL1_GUEST_ENABLED}" = "1" ]; then
			RET_CODE="1"
		fi
	fi
	if [ "2g" = "`syscfg get wifi_sta_radio`" ] && [ "1" = "`syscfg get wifi_sta_enabled`" ]; then
		ulog wlan status "${SERVICE_NAME}, PSTA mode, do not need MBSS"
		RET_CODE="0"
	fi
	return ${RET_CODE}
