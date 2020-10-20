	ulog wlan status "${SERVICE_NAME}, get_modem_version_number()"
	COMMAND="sys tpget sys show sysinfo"
	RESULT=`process_command "$COMMAND"`
	FW_VER="`echo $RESULT | awk -F"fwver=" '{print $2}' | cut -d' ' -f1`"
	echo $FW_VER
	return 0
