	ulog wlan status "${SERVICE_NAME}, get_downstream_attenuation_db_handler()"
	
	COMMAND="sys tpget sys show sysstatus"
	RESULT=`process_command "$COMMAND"`
	VALUE="`echo $RESULT | awk -F"attendown=" '{print $2}' | tr -d ' ' | cut -d',' -f1`"
	echo $VALUE
	return 0
