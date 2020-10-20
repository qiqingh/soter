	ulog wlan status "${SERVICE_NAME}, get_downstream_noise_margin_db_handler()"
	
	COMMAND="sys tpget sys show sysstatus"
	RESULT=`process_command "$COMMAND"`
	VALUE="`echo $RESULT | awk -F"snrdown=" '{print $2}' | tr -d ' ' | cut -d',' -f1`"
	echo $VALUE
	return 0
