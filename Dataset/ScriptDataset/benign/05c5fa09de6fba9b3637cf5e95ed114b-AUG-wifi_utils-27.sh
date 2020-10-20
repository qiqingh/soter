	REGION_CODE=`skuapi -g cert_region | awk -F"=" '{print $2}' | sed 's/ //g'`
	if [ -z "$REGION_CODE" ]; then
		REGION_CODE=`syscfg_get device::cert_region`
	fi
	if [ -z "$REGION_CODE" ]; then
		REGION_CODE="US"
	fi
	case "$REGION_CODE" in
		"US")		
			syscfg_set wl0_available_channels "$US_CH_LIST_2G"
			syscfg_set wl1_available_channels "$US_CH_LIST_5G"
			if [ "1" = "`syscfg get wifi::band_steering_configure`" ] ; then
				syscfg_set wl1_available_channels "36,40,44,48"
				syscfg_set wl2_available_channels "149,153,157,161,165"
			fi
			syscfg_commit
			;;
		"CA")		
			syscfg_set wl0_available_channels "$CA_CH_LIST_2G"
			syscfg_set wl1_available_channels "$CA_CH_LIST_5G"
			if [ "1" = "`syscfg get wifi::band_steering_configure`" ] ; then
				syscfg_set wl1_available_channels "36,40,44,48"
				syscfg_set wl2_available_channels "149,153,157,161,165"
			fi
			syscfg_commit
			;;
		"AP")		
			syscfg_set wl0_available_channels "$AP_CH_LIST_2G"
			syscfg_set wl1_available_channels "$AP_CH_LIST_5G"
			if [ "1" = "`syscfg get wifi::band_steering_configure`" ] ; then
				syscfg_set wl1_available_channels "36,40,44,48"
				syscfg_set wl2_available_channels "149,153,157,161,165"
			fi
			syscfg_commit
			;;
		"AU")		
			syscfg_set wl0_available_channels "$AU_CH_LIST_2G"
			syscfg_set wl1_available_channels "$AU_CH_LIST_5G"
			if [ "1" = "`syscfg get wifi::band_steering_configure`" ] ; then
				syscfg_set wl1_available_channels "36,40,44,48"
				syscfg_set wl2_available_channels "149,153,157,161,165"
			fi
			syscfg_commit
			;;
		"ID")		
			syscfg_set wl0_available_channels "$ID_CH_LIST_2G"
			syscfg_set wl1_available_channels "$ID_CH_LIST_5G"
			if [ "1" = "`syscfg get wifi::band_steering_configure`" ] ; then
				syscfg_set wl2_available_channels "$ID_CH_LIST_5G"
			fi
			CHANNEL=`syscfg get wl1_channel`
			if [ "0" != "$CHANNEL" ] && [ "149" != "$CHANNEL" ] && [ "153" != "$CHANNEL" ] && [ "157" != "$CHANNEL" ] && [ "161" != "$CHANNEL" ] ; then
				syscfg_set wl1_channel 149
			fi
			CHANNEL=`syscfg get wl2_channel`
			if [ "0" != "$CHANNEL" ] && [ "149" != "$CHANNEL" ] && [ "153" != "$CHANNEL" ] && [ "157" != "$CHANNEL" ] && [ "161" != "$CHANNEL" ] ; then
				syscfg_set wl2_channel 161
			fi
			syscfg_commit
			;;
		"EU")
			syscfg_set wl0_available_channels "$EU_CH_LIST_2G"
			syscfg_set wl1_available_channels "$EU_CH_LIST_5G"
			syscfg_commit
			;;
		*)
			ulog wlan status "wifi, Invalid region code, could not set on WiFi" > /dev/console
			;;
	esac
	return
