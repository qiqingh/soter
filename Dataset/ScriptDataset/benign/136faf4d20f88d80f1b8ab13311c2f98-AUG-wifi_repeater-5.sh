	echo "${SERVICE_NAME}, post_connect()"
	COUNTER=0
	LINK_STATUS=0
	while [ $COUNTER -lt 12 ] && [ "0" = "$LINK_STATUS" ]
	do
	if [ $COUNTER -ge 3 ]; then
            echo "previous detecting root AP failed, try again" > /dev/console
			wifi_repeater_init
			wifi_repeater_connect
            sleep 10
        fi
		sleep 10
        check_sta_connection $STA_IF
        LINK_STATUS=$?
		if [ "$LINK_STATUS" = "1" ]; then
			sysevent set wifi_sta_up 1
            sysevent set phylink_wan_state up
			echo "${SERVICE_NAME}, post_connect(), $STA_IF connected to $SSID successfully"
			return 0
		fi
		COUNTER=`expr $COUNTER + 1`
		echo "${SERVICE_NAME}, verifying $STA_IF connection to $SSID"
	done
	sysevent set wifi_sta_up 0
    sysevent set phylink_wan_state down
	echo "${SERVICE_NAME}, post_connect(), $STA_IF unable to verify connection to $SSID"
	return 1
