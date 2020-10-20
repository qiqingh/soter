	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	HTBW=`get_driver_bandwidth "$PHY_IF"`
	CHANNEL=`syscfg_get "$SYSCFG_INDEX"_channel`
	if [ "165" = "$CHANNEL" ]; then
		HTBW="$HTBW_20MHZ"
	fi
	SYSCFG_BW=`syscfg_get "$SYSCFG_INDEX"_radio_band`
	WL1_AC_SUPPORTED=`syscfg_get wl1_ac_supported`
	LEGALCY=`is_legalcy_mode $PHY_IF`
	if [ "true" = "$LEGALCY" ]; then
		set_wifi_val $PHY_IF HT_BW "$HTBW_20MHZ"
		if [ "wl1" = "$SYSCFG_INDEX" ] && [ "0" != "$WL1_AC_SUPPORTED" ] ; then
			set_wifi_val $PHY_IF VHT_BW 0
		fi
		if [ "$HTBW_40MHZ" = "$HTBW" ]; then
			syscfg_set "$SYSCFG_INDEX"_radio_band "standard"
		fi
	else
		set_wifi_val $PHY_IF HT_BW "$HTBW"
		if [ "wl1" = "$SYSCFG_INDEX" ] && [ "0" != "$WL1_AC_SUPPORTED" ] ; then
			VHTBW=`get_driver_vht_bandwidth "$PHY_IF"`
			if [ "1" = "$VHTBW" ] ; then
				echo "wifi, $PHY_IF VhtBw=1 (80 MHz)"
			fi
			set_wifi_val $PHY_IF VHT_BW $VHTBW
		fi
		
		if [ "wl0" = "$SYSCFG_INDEX" ] ; then
			set_wifi_val $PHY_IF HT_EXTCHA 0
		fi
		if [ "$HTBW_40MHZ" = "$HTBW" ] && [ "wl0" = "$SYSCFG_INDEX" ] && [ "0" != "$CHANNEL" ]; then
			SIDEBAND=`get_sideband "$PHY_IF"`
			set_wifi_val $PHY_IF HT_EXTCHA $SIDEBAND
		fi
	fi
	return 0
