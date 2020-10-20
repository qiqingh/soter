	ulog wlan status "${SERVICE_NAME}, is_modem_found()"
	COMMAND="sys tpget sys show sysinfo"
	
	RESULT=`process_command "$COMMAND"`
	LABEL="`echo $RESULT | awk -F"=" '{print $1}'`"
	if 	[ "$LABEL" = "syspwd" ]; then
		RET_CODE="1" 
		MODEM_MAC="`echo $RESULT | awk -F"mac=" '{print $2}' | cut -d',' -f1`"
		if [ ! -z "$MODEM_MAC" ] ; then
			sysevent set modem_mac $MODEM_MAC
		fi
		configure_modem_ip 
	else
		RET_CODE="0"
	fi
	echo $RESULT
	return "$RET_CODE"
