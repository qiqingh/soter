	NAS_EAPD_IF_LIST=""
	WPS_EAPD_IF_LIST=""
	WL0_WPS_STATE=""
	WL1_WPS_STATE=""
	STATE_24=`syscfg get wl0_state`
	STATE_5=`syscfg get wl1_state`
	VAP_24=`syscfg get wl0_user_vap`
	VAP_5=`syscfg get wl1_user_vap`
	VAP_TC=`syscfg get tc_vap_user_vap`
	SECURITY_24=`syscfg get wl0_security_mode`
	SECURITY_5=`syscfg get wl1_security_mode`
	WIFI_STA=`syscfg get wifi_sta_user_vap`
	if [ "1" = "`sysevent get wifi_sta_up`" ]; then
		if [ "$WIFI_STA" = "$VAP_24" ] ; then
			STATE_24="down"
		elif [ "$WIFI_STA" = "$VAP_5" ] ; then
			STATE_5="down"
		fi
	fi
	set_wps_state
	final_wps_state_check
	if [ "up" = "$STATE_24" ] || [ "up" = "$STATE_5" ]; then
		if [ "up" = "$STATE_24" ] && [ "wep" != "$SECURITY_24" ]; then
			NAS_EAPD_IF_LIST="$VAP_24"
		fi
		if [ "up" = "$STATE_5" ] && [ "wep" != "$SECURITY_5" ]; then
			NAS_EAPD_IF_LIST=`echo "$NAS_EAPD_IF_LIST $VAP_5"`
		fi
		if [ "1" = "`syscfg get tc_vap_enabled`" ] && [ "up" = "$STATE_24" ]; then
			NAS_EAPD_IF_LIST=`echo "$NAS_EAPD_IF_LIST $VAP_TC"`
		fi
		if [ "1" = "`sysevent get wifi_sta_up`" ]; then
			NAS_EAPD_IF_LIST=`echo "$NAS_EAPD_IF_LIST $WIFI_STA"`
		fi
		/usr/sbin/nas_wrapper
	fi
	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		if [ "wl0" = "$WL_SYSCFG" ]; then
			WL0_WPS_STATE=`sysevent get "$WL_SYSCFG"_wps_status`
		elif [ "wl1" = "$WL_SYSCFG" ]; then
			WL1_WPS_STATE=`sysevent get "$WL_SYSCFG"_wps_status`
		fi
		DEF_SSID=`syscfg get wl_default_ssid`
		if [ "unconfigured" = "$WL0_WPS_STATE" ] || [ "unconfigured" = "$WL1_WPS_STATE" ]; then
			nvram_set wps_device_name "$DEF_SSID "AP
			nvram_set lan_wps_oob enabled
			nvram_unset wps_pinfail_state
			nvram_unset wps_sta_devname
			nvram_unset wps_sta_mac
		elif [ "configured" = "$WL0_WPS_STATE" ] || [ "configured" = "$WL1_WPS_STATE" ]; then
			USR_SSID=`syscfg get wl0_ssid`
			if [ -z "$USR_SSID" ]; then
				USR_SSID=`syscfg get wl1_ssid`
			fi
			nvram_set wps_device_name "$USR_SSID "AP
			nvram_set lan_wps_oob disabled
		else
			nvram_set wps_device_name "$DEF_SSID "AP
		fi
	done
	
	if [ "disabled" != "$WL0_WPS_STATE" ] || [ "disabled" != "$WL1_WPS_STATE" ]; then
		initialize_wps
		if [ "disabled" != "$WL0_WPS_STATE" ] && [ "up" = "$STATE_24" ]; then
			VAP_24=`syscfg get wl0_user_vap`
			WPS_EAPD_IF_LIST="$VAP_24"
		fi
		if [ "disabled" != "$WL1_WPS_STATE" ] && [ "up" = "$STATE_5" ]; then
			VAP_5=`syscfg get wl1_user_vap`
			WPS_EAPD_IF_LIST=`echo "$WPS_EAPD_IF_LIST $VAP_5"`
		fi
		/bin/eapd -nas $NAS_EAPD_IF_LIST -wps $WPS_EAPD_IF_LIST
		configure_wps "$WPS_EAPD_IF_LIST"
	else
		/bin/eapd -nas $NAS_EAPD_IF_LIST
	fi
