	wl_index=0
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [" $EXTENDER_RADIO_MODE" = "1" ]; then
			wl_index=1
		else
			wl_index=0
		fi
	else
		check=`echo $1 | cut -c3`
		if [ "$check" = "i" ]; then
			wl_index=1
		else
			wl_index=0
		fi
	fi
	return "$wl_index"
