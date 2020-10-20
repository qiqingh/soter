	ulog wlan status "${SERVICE_NAME}, get_modem_wan_connection_status_handler()"
	COMMAND="sys tpget wan adsl status"
	RESULT=`process_command "$COMMAND"`
	if [ "$RESULT" = "current modem status: down" ]; then
		echo "down"
	elif  [ "$RESULT" = "current modem status: initialization" ]; then
		echo "initialization"
	elif  [ "$RESULT" = "current modem status: initializing" ]; then
		echo "initializing"
	elif  [ "$RESULT" = "current modem status: up" ]; then
		echo "up"
	else
		echo "unknown"
	fi
	return 0
