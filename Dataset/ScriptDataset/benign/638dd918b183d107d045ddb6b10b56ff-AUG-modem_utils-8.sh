	ulog wlan status "${SERVICE_NAME}, is_dsl_up()"
	COMMAND="sys tpget wan adsl status"
	DURATION="90"
	CURRENT_TIME=`date +%s`
	END_TIME=`expr "$CURRENT_TIME" + "$DURATION"`
	while [ "$CURRENT_TIME" -lt "$END_TIME" ]; do
		RESULT=`process_command "$COMMAND"`
		echo "=> ${SERVICE_NAME}, $RESULT (`date`)" > /dev/console
		if [ "$RESULT" = "current modem status: up" ]; then
			echo "${SERVICE_NAME}, adsl link is up" > /dev/console
			ulog wlan status "${SERVICE_NAME}, adsl link is up"
			echo "UP"
			return 1
		else
			sleep 1
			CURRENT_TIME=`date +%s`
		fi
	done
	echo "${SERVICE_NAME}, ERROR: adsl link is not up, $DURATION seconds timed out" > /dev/console
	ulog wlan status "${SERVICE_NAME}, ERROR: adsl link is not up, $DURATION seconds timed out"
	echo "DOWN"
	return 0
