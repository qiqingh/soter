	ulog wlan status "${SERVICE_NAME}, service_init()"
	MODEM_ENABLED=`syscfg_get modem::enabled`
	if [ "$MODEM_ENABLED" = "0" ] || [ -z "$MODEM_ENABLED" ]; then
		echo "${SERVICE_NAME}, modem is disabled, do not configure modem" 1>&2
		ulog wlan status "${SERVICE_NAME}, modem is disabled, do not configure modem" 1>&2
		sysevent set modem_detection_status "NOTFOUND"
		sysevent set modem_state "NOTCONFIGURED"
		syscfg_set modem::state "NOTCONFIGURED"
		exit 3
	fi
	modem_onetime_setting
	return 0
