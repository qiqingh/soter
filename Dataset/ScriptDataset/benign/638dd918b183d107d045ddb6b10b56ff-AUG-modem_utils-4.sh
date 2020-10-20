	ulog wlan status "${SERVICE_NAME}, configure_pvc()"
	echo "${SERVICE_NAME}, configure_pvc()" > /dev/console
	RET_CODE="OK"
	SYSCFG_INDEX=`syscfg_get modem::index`
	if [ -z "$SYSCFG_INDEX" ]; then
		SYSCFG_INDEX="0"
		syscfg_set modem::index $SYSCFG_INDEX
	fi
	SYSCFG_VID=`syscfg_get modem::vlan_tag`
	if [ -z "$SYSCFG_VID" ]; then
		SYSCFG_VID="2"
		syscfg_set modem::vlan_tag $SYSCFG_VID
	fi
	SYSCFG_VPI=`syscfg_get modem::vpi`
	SYSCFG_VCI=`syscfg_get modem::vci`
	MULTIPLEXING=`syscfg_get modem::multiplexing`
	if [ "$MULTIPLEXING" = "llc" ]; then
		SYSCFG_ENCAP="0"
	else
		SYSCFG_ENCAP="1"
	fi
	CONNECTION_TYPE=`syscfg_get modem::protocol`
	if [ "$CONNECTION_TYPE" = "pppoa" ] || [ "$CONNECTION_TYPE" = "ipoa" ]; then
		SYSCFG_MODE="1"
	else
		SYSCFG_MODE="0"
	fi
	COMMAND="sys tpget wan atm pvc disp 0"
	RESULT=`process_command "$COMMAND"`
	MODEM_INDEX="`echo $RESULT | awk -F"index=" '{print $2}' | cut -d',' -f1`"
	MODEM_VID="`echo $RESULT | awk -F"vid=" '{print $2}' | cut -d',' -f1`"
	MODEM_VPI="`echo $RESULT | awk -F"vpi=" '{print $2}' | cut -d',' -f1`"
	MODEM_VCI="`echo $RESULT | awk -F"vci=" '{print $2}' | cut -d',' -f1`"
	MODEM_ENCAP="`echo $RESULT | awk -F"encap=" '{print $2}' | cut -d',' -f1`"
	MODEM_MODE="`echo $RESULT | awk -F"mode=" '{print $2}' | cut -d',' -f1`"
	delete_pvc 1
	if [ "$SYSCFG_INDEX" != "$MODEM_INDEX" ] || [ "$SYSCFG_VID" != "$MODEM_VID" ]  || [ "$SYSCFG_VPI" != "$MODEM_VPI" ] || [ "$SYSCFG_VCI" != "$MODEM_VCI" ] || [ "$SYSCFG_ENCAP" != "$MODEM_ENCAP" ] || [ "$SYSCFG_MODE" != "$MODEM_MODE" ]; then
		COMMAND="sys tpset wan atm pvc add $SYSCFG_INDEX $SYSCFG_VID $SYSCFG_VPI $SYSCFG_VCI $SYSCFG_ENCAP $SYSCFG_MODE"
		RET_CODE=`process_command "$COMMAND"`
	else
		ulog wlan status "${SERVICE_NAME}, no PVC changes detected"
		echo "${SERVICE_NAME}, no PVC changes detected" > /dev/console
	fi
	echo $RET_CODE
	return 0
