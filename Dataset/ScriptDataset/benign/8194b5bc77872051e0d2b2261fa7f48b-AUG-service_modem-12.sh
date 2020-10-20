	ulog wlan status "${SERVICE_NAME}, get_downstream_data_rate_handler()"
	COMMAND="sys tpget sys show sysstatus"
	RESULT=`process_command "$COMMAND"`
	VALUE="`echo $RESULT | awk -F"dataratedown=" '{print $2}' | tr -d ' ' | cut -d',' -f1`"
	echo $VALUE
	return 0
