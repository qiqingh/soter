	ulog wlan status "${SERVICE_NAME}, configure_modem_ip()"
	COMMAND="sys tpget sys show lan"
	RESULT=`process_command "$COMMAND"`
	LABEL="`echo $RESULT | awk -F"=" '{print $1}'`"
	if 	[ "$LABEL" = "lanip" ]; then
		MODEM_IP="`echo $RESULT | awk -F"lanip=" '{print $2}' | cut -d',' -f1`"
		SYSCFG_MODEM_IP=`syscfg_get modem::ipaddr`
		if [ "$MODEM_IP" !=  "$SYSCFG_MODEM_IP" ] ; then
			echo "${SERVICE_NAME}, assign new ip=$SYSCFG_MODEM_IP to replace $MODEM_IP" > /dev/console
			ulog wlan status "${SERVICE_NAME}, assign new ip=$SYSCFG_MODEM_IP to replace $MODEM_IP" > /dev/console
			COMMAND="sys tpset ip addr $SYSCFG_MODEM_IP"
			RESULT=`process_command "$COMMAND"`
		fi
	fi
	echo $RESULT
	return 0
