	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	USER_SSID=`syscfg_get "$SYSCFG_INDEX"_ssid`
	GUEST_VAP=`syscfg_get "$SYSCFG_INDEX"_guest_vap`
	MAX_SSID_LEN=32
	GUEST_SSID_SUFFIX=`syscfg_get guest_ssid_suffix`
	MAX_GUEST_SSID_PREFIX=`expr $MAX_SSID_LEN - ${#GUEST_SSID_SUFFIX}`
	if [ "$SYSCFG_INDEX" = "wl0" ]; then
		GUEST_SSID=`syscfg_get guest_ssid`
	else
		GUEST_SSID=`syscfg_get "$SYSCFG_INDEX"_guest_ssid`
	fi
	if [ -n "$USER_SSID"  ]; then
		GUEST_SSID="${USER_SSID:0:$MAX_GUEST_SSID_PREFIX}$GUEST_SSID_SUFFIX"
		ulog guest status "Guest SSID = $GUEST_SSID"
		ulog guest status "Syscfg Guest SSID = $GUEST_SSID"
		if [ "$GUEST_SSID" != "$GUEST_SSID" ]; then
			utctx_cmd set guest_ssid="$GUEST_SSID"
			return 1;
		fi
	fi
	return 0;
