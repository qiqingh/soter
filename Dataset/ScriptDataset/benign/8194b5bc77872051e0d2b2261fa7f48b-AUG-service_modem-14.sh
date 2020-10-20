	ulog wlan status "${SERVICE_NAME}, get_downstream_output_power_dbm_handler()"
	
	COMMAND="sys tpget sys show sysotherstatus"
	RESULT=`process_command "$COMMAND"`
	VALUE="`echo $RESULT | awk -F"powerdown=" '{print $2}' | tr -d ' ' | cut -d',' -f1`"
	echo $VALUE
	return 0
