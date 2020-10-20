	PHY_IF=$1
	VIR_IF=$2
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	iwconfig $VIR_IF key off
	SSID_BROADCAST=`get_ssid_broadcast $SYSCFG_INDEX`
	if [ "1" = $SSID_BROADCAST ]; then
		iwpriv $VIR_IF hide_ssid 0
	else
		iwpriv $VIR_IF hide_ssid 1
	fi
	SEC_ENABLED="false"
	LOCAL_SEC_MODE=`syscfg_get $SYSCFG_INDEX"_security_mode"`
	if [ "wpa-personal" = "$LOCAL_SEC_MODE" ] || [ "wpa2-personal" = "$LOCAL_SEC_MODE" ] || [ "wpa-mixed" = "$LOCAL_SEC_MODE" ]; then
		SEC_ENABLED="true"
	fi
	 	
	if [ "true" = "$SEC_ENABLED" ]; then
		USE_HOSTAPD=`syscfg_get wl_use_hostapd`
		if [ "1" != "$USE_HOSTAPD" ]; then
			REKEY_TIME=`syscfg_get $SYSCFG_INDEX"_key_renewal"`
			iwpriv $VIR_IF grouprekey `expr $REKEY_TIME`
		fi
	fi
	AP_ISOLATION=`syscfg_get $SYSCFG_INDEX"_ap_isolation"`
	if [ "disabled" = "$AP_ISOLATION" ]; then
		L2TIF=0
	else
		L2TIF=1
	fi
	iwpriv $VIR_IF l2tif $L2TIF
	DTIM_INTERVAL=`syscfg_get $SYSCFG_INDEX"_dtim_interval"`
	if [ -z "$DTIM_INTERVAL" ] || [ $DTIM_INTERVAL -lt 1 ] || [ $DTIM_INTERVAL -gt 255 ]; then
		ulog wlan status "invalid wifi dtim_interval $DTIM_INTERVAL"
		DTIM_INTERVAL=1
	fi
	iwpriv $VIR_IF dtim_period $DTIM_INTERVAL
	AMSDU_SETTING=`syscfg_get $SYSCFG_INDEX"_amsdu_enabled"`
	iwpriv $VIR_IF amsdu $AMSDU_SETTING
	return 0
