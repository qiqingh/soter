	echo "wifi, $PHY_IF wps_status_callback SUCCESS received"
    CRED_FILE=/tmp/wps_cred.$PHY_IF
	wlan_query -i $PHY_IF -p wps_cred > $CRED_FILE
	SSID=`cat $CRED_FILE | grep "SSID : " | awk -F "SSID : " '{ print $2 }'`
	SECURITY=`cat $CRED_FILE | grep "AuthMode : " | awk -F "AuthMode : " '{ print $2 }'`
	PASSPHRASE=`cat $CRED_FILE | grep "WPAPSK : "  | awk -F "WPAPSK : " '{ print $2 }'`
	sysevent set wps_process "completed"
	if [ $SECURITY != "0" ]; then
	echo "	wifi debug, wps_cred ssid: "$SSID""
	echo "	wifi debug, wps_cred passphrase: "$PASSPHRASE""
	echo "	wifi debug, wps_cred security: "$SECURITY""
	get_syscfg_security $SECURITY
	echo "	wifi debug, $PHY_IF syscfg security: $SYSCFG_SEC"
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_SSID=`syscfg_get "$SYSCFG_INDEX"_ssid`
	SYSCFG_PASSPHRASE=`syscfg_get "$SYSCFG_INDEX"_passphrase`	
	SYSCFG_SECURITY_MODE=`syscfg_get "$SYSCFG_INDEX"_security_mode`
	if [ "$SYSCFG_SSID" != "$SSID" ] || [ "$SYSCFG_PASSPHRASE" != "$PASSPHRASE" ] || [ "$SYSCFG_SECURITY_MODE" != "$SYSCFG_SEC" ] ; then
		echo "wifi, $PHY_IF wps_status_callback: syncing syscfg with wps credentials"
        if [ "$PHY_IF" = "ra0" ]; then
            update_2g_setting "$SSID" "$PASSPHRASE" "$SYSCFG_SEC"
        else
            update_5g_setting "$SSID" "$PASSPHRASE" "$SYSCFG_SEC"
        fi
        update_wifi_cache "physical"
        update_wifi_cache "virtual"
        update_wifi_cache "guest"
        if [ "$PHY_IF" = "ra0" ]; then
            update_5g_setting "$SSID" "$PASSPHRASE" "$SYSCFG_SEC"
        else
            update_2g_setting "$SSID" "$PASSPHRASE" "$SYSCFG_SEC"
        fi
		sysevent set wifi_config_changed
	fi
	fi
