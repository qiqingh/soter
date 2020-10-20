	if [ "Extender" = $DEVICE_TYPE ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			wlname="wl1"
		else
			wlname="wl0"
		fi
	else
		wlname=$1;
	fi
	echo "$wlname"
