	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		wps_state="unconfigured"
		ssid_broadcast=`get_ssid_broadcast $WL_SYSCFG`
		WL_MACFILTER_ENABLED=`syscfg get wl_access_restriction`
		sec_mode=`get_wpa_auth $WL_SYSCFG`
		WL_VAP_STATE=`syscfg get ${WL_SYSCFG}_state`
		if [ "$WL_VAP_STATE" = "down" ] || [ 1 = $sec_mode ] || [ 2 = $sec_mode ] || [ 4 = $sec_mode ] || 
			[ 8 = $sec_mode ] || [ 64 = $sec_mode ] || [ 66 = $sec_mode ] || [ 0 = $ssid_broadcast ]; then
			wps_state="disabled"
		fi
		if [ "disabled" != "$wps_state" ]; then
			ssid=`syscfg get ${WL_SYSCFG}_ssid`
			if [ "$ssid" != "`syscfg get ${WL_SYSCFG}_default_ssid`" ] && [ "$ssid" != "`syscfg get wl_default_ssid`" ] ; then
				wps_state="configured"
			else
				if [ 0 != $sec_mode ]; then
					wps_state="configured"
				fi
			fi
		fi	
		if [ "$WL_MACFILTER_ENABLED" = "allow" ] || [ "$WL_MACFILTER_ENABLED" = "deny" ]; then
			wps_state="disabled"
		fi
		WPS_USER_SETTING=`syscfg get wps_user_setting`
		if [ "disabled" = "$WPS_USER_SETTING" ]; then
			wps_state="disabled"
		fi
		sys_wps_state=`syscfg get ${WL_SYSCFG}_wps_state`
		if [ "$sys_wps_state" != "$wps_state" ]; then
			syscfg_set ${WL_SYSCFG}_wps_state $wps_state
		fi
		sysevent set ${WL_SYSCFG}_wps_status $wps_state
		NVRAM_WL=`syscfg_nvram_map $WL_SYSCFG`
		if [ "disabled" = "$wps_state" ]; then
			nvram_set ${NVRAM_WL}_wps_mode disabled
		else
			nvram_set ${NVRAM_WL}_wps_mode enabled
			wps_set_nvram_params
		fi
	done
	
