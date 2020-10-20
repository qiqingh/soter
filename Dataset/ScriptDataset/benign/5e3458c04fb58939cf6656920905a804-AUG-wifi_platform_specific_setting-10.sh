	USER_VAP=$1
	WL_SYSCFG=`get_syscfg_interface_name $USER_VAP`
	SSID_BROADCAST=`get_ssid_broadcast $WL_SYSCFG`
	if [ "1" = $SSID_BROADCAST ]; then
		wl -i $USER_VAP closed 0
	else
		wl -i $USER_VAP closed 1
	fi
	SEC_ENABLED="false"
	SEC_MODE=`syscfg get $WL_SYSCFG"_security_mode"`
	if [ "wpa-personal" = "$SEC_MODE" ] || [ "wpa2-personal" = "$SEC_MODE" ] || [ "wpa-mixed" = "$SEC_MODE" ]; then
		SEC_ENABLED="true"
	fi
	if [ "true" = "$SEC_ENABLED" ]; then
		REKEY_TIME=`syscfg get $WL_SYSCFG"_key_renewal"`
	fi
	AP_ISOLATION=`syscfg get $WL_SYSCFG"_ap_isolation"`
	if [ "enabled" = "$AP_ISOLATION" ]; then
		INTRABSS=1
	else
		INTRABSS=0
	fi
	wl -i $USER_VAP ap_isolate $INTRABSS
	FRAME_BURST=`syscfg get $WL_SYSCFG"_frame_burst"`
	if [ "enabled" = "$FRAME_BURST" ]; then
		OPTLEVEL=1
	else
		OPTLEVEL=0
	fi
	wl -i $USER_VAP frameburst $OPTLEVEL
	return
