	ulog wlan status "${SERVICE_NAME}, configure_qos()"
	echo "${SERVICE_NAME}, configure_qos()" > /dev/console
	RET_CODE="OK"
	SYSCFG_QOS_TYPE=`syscfg_get modem::qos_type`
	if [ -z "$SYSCFG_QOS_TYPE" ]; then
		SYSCFG_QOS_TYPE="ubr"
		syscfg_set modem::qos_type "ubr"
	fi
	SYSCFG_PCR=`syscfg_get modem::pcr`
	if [ -z "$SYSCFG_PCR" ]; then
		SYSCFG_PCR="0"
		syscfg_set modem::pcr $SYSCFG_PCR
	fi
	SYSCFG_SCR=`syscfg_get modem::scr`
	if [ -z "$SYSCFG_SCR" ]; then
		SYSCFG_SCR="0"
		syscfg_set modem::scr $SYSCFG_SCR
	fi
	SYSCFG_MBS=`syscfg_get modem::mbs`
	if [ -z "$SYSCFG_MBS" ]; then
		SYSCFG_MBS="0"
		syscfg_set modem::mbs $SYSCFG_MBS
	fi
	SYSCFG_RN=1
	COMMAND="sys tpget wan atm pvc disp 0"
	RESULT=`process_command "$COMMAND"`
	MODEM_QOS_TYPE="`echo $RESULT | awk -F"qostype=" '{print $2}' | cut -d',' -f1`"
	if [ "$MODEM_QOS_TYPE" = "0" ]; then
		MODEM_QOS_TYPE="ubr"
	elif [ "$MODEM_QOS_TYPE" = "1" ]; then
		MODEM_QOS_TYPE="vbr"
	elif [ "$MODEM_QOS_TYPE" = "3" ]; then
		MODEM_QOS_TYPE="cbr"
	elif [ "$MODEM_QOS_TYPE" = "4" ]; then
		MODEM_QOS_TYPE="gfr"
	elif [ "$MODEM_QOS_TYPE" = "5" ]; then
		MODEM_QOS_TYPE="nrt_vbr"
	else
		MODEM_QOS_TYPE="ubr"
	fi
	MODEM_PCR="`echo $RESULT | awk -F"pcr=" '{print $2}' | cut -d',' -f1`"
	MODEM_SCR="`echo $RESULT | awk -F"scr=" '{print $2}' | cut -d',' -f1`"
	MODEM_MBS="`echo $RESULT | awk -F"mbs=" '{print $2}' | cut -d',' -f1`"
	if [ "$SYSCFG_QOS_TYPE" != "$MODEM_QOS_TYPE" ] || [ "$SYSCFG_PCR" != "$MODEM_PCR" ]  || [ "$SYSCFG_SCR" != "$MODEM_SCR" ] || [ "$SYSCFG_MBS" != "$MODEM_MBS" ]; then
		COMMAND="sys tpset wan atm setqos $SYSCFG_QOS_TYPE $SYSCFG_PCR $SYSCFG_SCR $SYSCFG_MBS $SYSCFG_RN"
		RET_CODE=`process_command "$COMMAND"`
	else
		ulog wlan status "${SERVICE_NAME}, no QOS changes detected"
		echo "${SERVICE_NAME}, no QOS changes detected" > /dev/console
	fi
	echo $RET_CODE
	return 0
