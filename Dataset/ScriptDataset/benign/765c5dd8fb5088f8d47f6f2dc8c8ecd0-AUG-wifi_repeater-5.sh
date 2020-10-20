	echo "${SERVICE_NAME}, post_connect()"
	COUNTER=0
	LINK_STATUS=0
	while [ $COUNTER -lt 30 ] && [ "0" = $LINK_STATUS ]
	do
		sleep 10
		if [ "1" = "`iwpriv $VIR_IF getlinkstatus | cut -d: -f2 | awk '{ print $1 }'`" ]; then
			LINK_STATUS=1
			brctl addif "$BRIDGE_NAME" "$VIR_IF"
			sysevent set wifi_sta_up 1
			echo "${SERVICE_NAME}, post_connect(), $VIR_IF connected to $STA_SSID successfully"
			return 0
		fi
		COUNTER=`expr $COUNTER + 1`
		echo "${SERVICE_NAME}, attempting to connect $VIR_IF to $STA_SSID"
	done
	sysevent set wifi_sta_up 0
	echo "${SERVICE_NAME}, post_connect(), $VIR_IF unable to connect to $STA_SSID"
	return 1
