	echo "${SERVICE_NAME}, post_connect()"
	COUNTER=0
	LINK_STATUS=0
	while [ $COUNTER -lt 30 ] && [ "0" = $LINK_STATUS ]
	do
		sleep 10
		if [ "1" = "`iwpriv $STA_IF getlinkstatus | cut -d: -f2 | awk '{ print $1 }'`" ]; then
			LINK_STATUS=1
			brctl addif "$BRIDGE_NAME" "$STA_IF"
			sysevent set wifi_sta_up 1
			echo "${SERVICE_NAME}, post_connect(), $STA_IF connected to $SSID successfully"
			return 0
		fi
		COUNTER=`expr $COUNTER + 1`
		echo "${SERVICE_NAME}, attempting to connect $STA_IF to $SSID"
	done
	sysevent set wifi_sta_up 0
	echo "${SERVICE_NAME}, post_connect(), $STA_IF unable to connect to $SSID"
	return 1
