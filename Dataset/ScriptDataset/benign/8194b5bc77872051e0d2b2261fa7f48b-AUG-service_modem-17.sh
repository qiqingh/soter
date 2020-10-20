	ulog wlan status "${SERVICE_NAME}, get_upstream_noise_margin_db_handler()"
	
	COMMAND="sys tpget sys show sysstatus"
	RESULT=`process_command "$COMMAND"`
	VALUE="`echo $RESULT | awk -F"snrup=" '{print $2}' | tr -d ' ' | cut -d',' -f1`"
	echo $VALUE
	return 0
