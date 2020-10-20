	SYSCFG_INDEX=$1
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			SYSCFG_INDEX="wl1"
		else
			SYSCFG_INDEX="wl0"
		fi
	fi
	ssid_broadcast=`syscfg_get ${SYSCFG_INDEX}_ssid_broadcast`
	if [ -z "$ssid_broadcast" ]; then
		ssid_broadcast=1
	fi
	echo "$ssid_broadcast"
