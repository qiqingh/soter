	ulog wlan status "${SERVICE_NAME}, modem_get_state()"
	STATE=`sysevent get modem_state`
	echo "$STATE"
	return 0
