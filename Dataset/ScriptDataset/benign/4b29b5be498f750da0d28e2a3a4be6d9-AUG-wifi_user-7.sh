	PHY_IF=$1
	VIR_IF=$2
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	USER_SSID=`syscfg_get $SYSCFG_INDEX"_ssid"`
	SEC_MODE=`get_security_mode "$SYSCFG_INDEX"_security_mode`
	USER_PASSPHRASE=""
	RADIUS_SERVER=""
	RADIUS_PORT=""
	RADIUS_SHARED=""
	ENC_MODE=""
	TX_KEY=""
	if [ -z "$USER_SSID" ]; then
		USER_SSID=`syscfg_get hostname`
	fi
	if [ "1" = $SEC_MODE ] || [ "2" = $SEC_MODE ] || [ "3" = $SEC_MODE ]; then
		WL_PASSPHRASE=`syscfg_get "$SYSCFG_INDEX"_passphrase`
		if [ ${#WL_PASSPHRASE} = 64 ]; then 
			USER_PASSPHRASE="wpa_psk=${WL_PASSPHRASE}"
		else
			USER_PASSPHRASE="wpa_passphrase=${WL_PASSPHRASE}"
		fi
	elif [ "4" = $SEC_MODE ] || [ "5" = $SEC_MODE ] || [ "6" = $SEC_MODE ]; then
		RADIUS_SERVER=`syscfg_get $SYSCFG_INDEX"_radius_server"`
		RADIUS_PORT=`syscfg_get $SYSCFG_INDEX"_radius_port"`
		RADIUS_SHARED=`syscfg_get $SYSCFG_INDEX"_shared"`
	elif [ "7" = $SEC_MODE ]; then
		RADIUS_SERVER=`syscfg_get $SYSCFG_INDEX"_radius_server"`
		RADIUS_PORT=`syscfg_get $SYSCFG_INDEX"_radius_port"`
		RADIUS_SHARED=`syscfg_get $SYSCFG_INDEX"_shared"`
	elif [ "8" = $SEC_MODE ]; then
		ENC_MODE=`syscfg_get $SYSCFG_INDEX"_encryption"`
		USER_PASSPHRASE=`syscfg_get $SYSCFG_INDEX"_passphrase"`
		TX_KEY=`syscfg_get $SYSCFG_INDEX"_tx_key"`
	fi
	if [ "1" = $SEC_MODE ] || [ "4" = $SEC_MODE ]; then
		syscfg_set $SYSCFG_INDEX"_encryption" "tkip"
	elif [ "2" = $SEC_MODE ] || [ "5" = $SEC_MODE ]; then
		syscfg_set $SYSCFG_INDEX"_encryption" "aes"
	elif [ "3" = $SEC_MODE ] || [ "6" = $SEC_MODE ]; then
		syscfg_set $SYSCFG_INDEX"_encryption" "tkip+aes"
	fi
	ulog wlan status "Bring up hostapd for $VIR_IF"
	USER_ENCRYPTION=`get_encryption $SYSCFG_INDEX"_encryption"`
	HOSTAPD_CONF="/tmp/hostapd-$VIR_IF.conf"
	wps_state=`syscfg_get "$SYSCFG_INDEX"_wps_state`
	if [ "configured" = "$wps_state" ]; then
		WPS_STATE=2
	elif [ "disabled" = "$wps_state" ]; then
		WPS_STATE=0
	else
		WPS_STATE=1
	fi
	if [ "4" = "$SEC_MODE" ] || [ "5" = "$SEC_MODE" ] || [ "6" = "$SEC_MODE" ]; then
		generate_hostapd_config_enterprise $VIR_IF "$USER_SSID" $SEC_MODE "$RADIUS_SERVER" "$RADIUS_PORT" "$RADIUS_SHARED"> $HOSTAPD_CONF
	else
		generate_hostapd_config $VIR_IF "$USER_SSID" "$USER_PASSPHRASE" $SEC_MODE "$USER_ENCRYPTION" "$RADIUS_SERVER" "$RADIUS_PORT" "$RADIUS_SHARED"> $HOSTAPD_CONF
	fi
	generate_hostapd_wps_section $SYSCFG_INDEX >> $HOSTAPD_CONF
	driver_update_extra_virtual_settings $PHY_IF $VIR_IF
	set_driver_mac_filter_enabled $VIR_IF
	return 0
