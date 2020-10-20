	PHY_IF=$1
	get_wifi_validation ${PHY_IF}
	VALID=$?
	if [ "$VALID" = "2" ]; then
		ulog wlan status "${SERVICE_NAME}, wifi setting is incompatible, reconfigure the network mode according to WPA mode on $SYSCFG_INDEX" > /dev/console
		current_bandwidth=`syscfg_get ${SYSCFG_INDEX}_radio_band`
		if [ "wl0" = "$SYSCFG_INDEX" ]; then
			syscfg_set ${SYSCFG_INDEX}_network_mode "11b 11g"
		else
			syscfg_set ${SYSCFG_INDEX}_network_mode "11a"
		fi
		
		if [ "wide" = "$current_bandwidth" ]; then
			syscfg_set ${SYSCFG_INDEX}_radio_band "auto"
		fi
	fi
	OPMODE=`get_driver_network_mode "$PHY_IF"`
	set_wifi_val $PHY_IF WirelessMode $OPMODE
	if [ "$NET_ANAC_MIXED" = "$OPMODE" ] ; then
		set_wifi_val $PHY_IF VHT_LDPC 1
		set_wifi_val $PHY_IF VHT_SGI  1
	else
		set_wifi_val $PHY_IF VHT_LDPC 0
		set_wifi_val $PHY_IF VHT_SGI  0
	fi
	
	return 0
