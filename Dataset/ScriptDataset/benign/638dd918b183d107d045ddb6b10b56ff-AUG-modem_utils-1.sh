	ulog wlan status "${SERVICE_NAME}, process_command($1)"
	COMMAND=$1
	CONTROL_IFNAME=`syscfg_get interface_5::ifname`
	MODEM_PASSWORD=`syscfg_get modem::password`
	
	RESULT=`bmw -i "$CONTROL_IFNAME" -p "$MODEM_PASSWORD" -c "$COMMAND"`
	echo $RESULT
