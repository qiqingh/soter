	ONETIME_SETTING=`sysevent get modem_onetime_setting`
	if [ "$ONETIME_SETTING" != "TRUE" ]; then
		echo "${SERVICE_NAME}, modem_onetime_setting()" > /dev/console
		ulog wlan status "${SERVICE_NAME}, modem_onetime_setting()"
		sysevent set modem_state `syscfg_get modem::state`
		sysevent set modem_detection_status "UNKNOWN"
		sysevent set modem_onetime_setting "TRUE"
	fi
	return 0
