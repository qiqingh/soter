	wl_index=0
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [" $EXTENDER_RADIO_MODE" = "1" ]; then
			wl_index=1
		else
			wl_index=0
		fi
	else
		wl_index=`echo $1 | cut -c4`
	fi
	return "$wl_index"
