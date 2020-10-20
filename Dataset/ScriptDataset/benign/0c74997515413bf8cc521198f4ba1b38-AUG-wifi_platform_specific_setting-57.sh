	WL0_WPS_STATE=`syscfg get wl0_wps_state`
	WL1_WPS_STATE=`syscfg get wl1_wps_state`
	if [ "$WL0_WPS_STATE" = "configured" ] || [ "$WL1_WPS_STATE" = "configured" ]; then
		if [ "$WL1_WPS_STATE" = "unconfigured" ]; then
			NVRAM_WL=`syscfg_nvram_map "wl1"`
			syscfg_set wl1_wps_state configured
			sysevent set wl1_wps_status configured
			nvram_set ${NVRAM_WL}_wps_mode enabled
		fi
		if [ "$WL0_WPS_STATE" = "unconfigured" ]; then
			NVRAM_WL=`syscfg_nvram_map "wl0"`
			syscfg_set wl0_wps_state configured
			sysevent set wl0_wps_status configured
			nvram_set ${NVRAM_WL}_wps_mode enabled
		fi
	fi
