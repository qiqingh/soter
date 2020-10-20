	MAX_SSID_LEN=32
	SUFFIX=`syscfg get guest_ssid_suffix`
	MAX_GUEST_SSID_PREFIX=`expr $MAX_SSID_LEN - ${#SUFFIX}`
	USER_SSID=`syscfg get wl0_ssid`
	OLD_GUEST_SSID=`syscfg get guest_ssid`
	if [ -n "$USER_SSID"  ]; then
		GUEST_SSID="${USER_SSID:0:$MAX_GUEST_SSID_PREFIX}$SUFFIX"
		ulog wlan status "${SERVICE_NAME}, Guest SSID = $GUEST_SSID"
		ulog wlan status "${SERVICE_NAME}, Syscfg Guest SSID = $OLD_GUEST_SSID"
		if [ "$OLD_GUEST_SSID" != "$GUEST_SSID" ]; then
			syscfg_set guest_ssid "$GUEST_SSID"
			return 1;
		fi
	fi
	return 0;
