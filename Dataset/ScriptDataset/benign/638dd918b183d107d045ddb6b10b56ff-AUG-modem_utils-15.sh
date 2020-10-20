	ulog wlan status "${SERVICE_NAME}, delete_pvc(index=$1)"
	PVC=$1
	COMMAND="sys tpget wan atm pvc disp $PVC"
	RESULT=`process_command "$COMMAND"`
	VPI1="`echo $RESULT | awk -F"vpi=" '{print $2}' | cut -d',' -f1`"
	VCI1="`echo $RESULT | awk -F"vci=" '{print $2}' | cut -d',' -f1`"
	if [ ! -z "$VPI1" ] && [ ! -z "$VCI1" ]; then
		echo "${SERVICE_NAME}, delete unused PVC1" > /dev/console
		ulog wlan status "${SERVICE_NAME}, delete unused PVC1" > /dev/console
		COMMAND="sys tpset wan atm pvc del $VPI1 $VCI1"
		RESULT=`process_command "$COMMAND"`
	fi
	return 0
