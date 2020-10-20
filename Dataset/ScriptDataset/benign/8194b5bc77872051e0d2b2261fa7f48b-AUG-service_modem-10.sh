	ulog wlan status "${SERVICE_NAME}, phylink_wan_state_handler()"
	modem_detection
	echo "${SERVICE_NAME}, modem detection status=`sysevent get modem_detection_status`, modem state=`sysevent get modem_state`"  1>&2
	ulog wlan status "${SERVICE_NAME}, modem detection status=`sysevent get modem_detection_status`, modem state=`sysevent get modem_state`"  1>&2
	return 0
