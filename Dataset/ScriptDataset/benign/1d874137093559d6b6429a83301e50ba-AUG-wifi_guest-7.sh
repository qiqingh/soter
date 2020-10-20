	PHY_IF=$1
	ulog guest status "${SERVICE_NAME}, configure_guest($PHY_IF) "
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$SYSCFG_INDEX"_guest_vap`
	if [ "$SYSCFG_INDEX" = "wl0" ]; then
		GUEST_SSID=`syscfg_get guest_ssid`
		GUEST_BROADCAST=`syscfg_get guest_ssid_broadcast`
	else
		GUEST_SSID=`syscfg_get "$SYSCFG_INDEX"_guest_ssid`
		GUEST_BROADCAST=`syscfg_get "$SYSCFG_INDEX"_guest_ssid_broadcast`
	fi
	
	if [ "$GUEST_BROADCAST" = "0" ] ; then
		HIDE_SSID=1
	else
		HIDE_SSID=0 
	fi
	iwconfig $GUEST_VAP essid "$GUEST_SSID"
	iwpriv $GUEST_VAP hide_ssid $HIDE_SSID
	return 0
