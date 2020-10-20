    PHY_IF=$1
	VIR_IF=$2
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SSID_BROADCAST=`get_ssid_broadcast $SYSCFG_INDEX`
	if [ "1" = $SSID_BROADCAST ]; then
		set_wifi_val $VIR_IF HideSSID 0
	else
		set_wifi_val $VIR_IF HideSSID 1
	fi
	SEC_ENABLED="false"
	LOCAL_SEC_MODE=`syscfg_get $SYSCFG_INDEX"_security_mode"`
	if [ "wpa-personal" = "$LOCAL_SEC_MODE" ] || [ "wpa2-personal" = "$LOCAL_SEC_MODE" ] || [ "wpa-mixed" = "$LOCAL_SEC_MODE" ]; then
		SEC_ENABLED="true"
	fi
	 	
	if [ "true" = "$SEC_ENABLED" ]; then
		REKEY_TIME=`syscfg_get $SYSCFG_INDEX"_key_renewal"`
		set_wifi_val $VIR_IF RekeyInterval $REKEY_TIME
	fi
	AP_ISOLATION=`syscfg_get $SYSCFG_INDEX"_ap_isolation"`
	if [ "enabled" = "$AP_ISOLATION" ]; then
		set_wifi_val $VIR_IF NoForwarding 1
	else
		set_wifi_val $VIR_IF NoForwarding 0
	fi
	FRAME_BURST=`syscfg_get $SYSCFG_INDEX"_frame_burst"`
	if [ "enabled" = "$FRAME_BURST" ]; then
		set_wifi_val $VIR_IF TxBurst 1
        echo "${SERVICE_NAME}, TxBurst 1"
	else
		set_wifi_val $VIR_IF TxBurst 0
        echo "${SERVICE_NAME}, TxBurst 0"
	fi
	DTIM_INTERVAL=`syscfg_get $SYSCFG_INDEX"_dtim_interval"`
	if [ -z "$DTIM_INTERVAL" ] || [ $DTIM_INTERVAL -lt 1 ] || [ $DTIM_INTERVAL -gt 255 ]; then
		ulog wlan status "invalid wifi dtim_interval $DTIM_INTERVAL"
		DTIM_INTERVAL=1
	fi
	set_wifi_val $VIR_IF DtimPeriod $DTIM_INTERVAL
	AMSDU_SETTING=`syscfg_get $SYSCFG_INDEX"_amsdu_enabled"`
	set_wifi_val $VIR_IF HT_AMSDU $AMSDU_SETTING
	if [ "EA2750" = "`syscfg_get device::model_base`" ] ; then
		reg s 0xB0000014
		reg r 0
		reg s 0xB0000014
		reg w 0 0x0440050f		
	fi
	return 0
