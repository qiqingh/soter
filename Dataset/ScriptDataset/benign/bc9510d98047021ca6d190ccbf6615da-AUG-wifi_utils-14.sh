	WL_SYSCFG=$1
	
	SYSCFG_BANDWIDTH=`syscfg get "$WL_SYSCFG"_radio_band`
	if [ "standard" = "$SYSCFG_BANDWIDTH" ]; then
		VENDOR_BANDWIDTH="20"
	elif [ "wide" = "$SYSCFG_BANDWIDTH" ]; then
		VENDOR_BANDWIDTH="40"
	elif [ "wide80" = "$SYSCFG_BANDWIDTH" ]; then
		VENDOR_BANDWIDTH="80"
	else
		AC_SUPPORTED=`is_11ac_supported $WL_SYSCFG`
		if [ "$AC_SUPPORTED" = "1" ]; then
			VENDOR_BANDWIDTH="80"
		else
			VENDOR_BANDWIDTH="40"
		fi
	fi
	NETWORK_MODE=`get_syscfg_network_mode $WL_SYSCFG`
	if [ "11a" = "$NETWORK_MODE" ] || [ "11b 11g" = "$NETWORK_MODE" ] || [ "11b" = "$NETWORK_MODE" ] || [ "11g" = "$NETWORK_MODE" ]; then
		VENDOR_BANDWIDTH="20"
	elif [ "11ac" != "$NETWORK_MODE" ] && [ "11a 11n 11ac" != "$NETWORK_MODE" ] && [ "80" = "$VENDOR_BANDWIDTH" ]; then
		VENDOR_BANDWIDTH="40"
	fi
	CHANNEL=`syscfg get ${WL_SYSCFG}_channel`
	if [ "165" = "$CHANNEL" ]; then
		VENDOR_BANDWIDTH="20"
	fi
	if [ "ID" = "`syscfg get device::cert_region`" ]; then
		VENDOR_BANDWIDTH="20"
	fi
	echo "$VENDOR_BANDWIDTH"
