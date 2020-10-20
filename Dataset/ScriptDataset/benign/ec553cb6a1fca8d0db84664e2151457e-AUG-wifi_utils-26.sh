	WL=$1
	SSID_BROADCAST=`syscfg get ${WL}_ssid_broadcast`
	if [ -z "$SSID_BROADCAST" ]; then
		SSID_BROADCAST=1
	fi
	echo "$SSID_BROADCAST"
