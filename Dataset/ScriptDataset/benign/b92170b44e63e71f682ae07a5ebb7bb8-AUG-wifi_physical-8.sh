	ulog wlan status "${SERVICE_NAME}, initialize_physical_station($1)"
	PHY_IF=$1
	CHANGE_STAMODE=false
	LDAL_STAMODE=`syscfg_get ldal_wl_stamode`
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			if [ "$LDAL_STAMODE" != "8" ]; then
				LDAL_STAMODE=8
				syscfg_set ldal_wl_stamode `expr $LDAL_STAMODE`
				CHANGE_STAMODE=true
			fi
		else 
			if [ "$LDAL_STAMODE" != "7" ]; then
				LDAL_STAMODE=7
				syscfg_set ldal_wl_stamode `expr $LDAL_STAMODE`
				CHANGE_STAMODE=true
			fi
		fi
		if [ "$CHANGE_STAMODE" = "true" ]; then
			LDAL_VSTA=`syscfg_get ldal_wl_vsta`
			iwpriv `echo $LDAL_VSTA | cut -c1-5` autochannel 1
		fi
		ulog wlan status "Bring down the vsta to avoid continue scanning" > /dev/console
		LDAL_VSTA=`syscfg_get ldal_wl_vsta`
		ifconfig "$LDAL_VSTA" down
	fi
	return 0
