	PHY_IF=$1
	INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$INDEX"_guest_vap`
	if [ "ra0" = "$PHY_IF" ]; then
		GUEST_SSID=`syscfg_get guest_ssid`
		SSID_BROADCAST=`syscfg_get guest_ssid_broadcast`
	elif [ "rai0" = "$PHY_IF" ]; then
		GUEST_SSID=`syscfg_get "$INDEX"_guest_ssid`
		SSID_BROADCAST=`syscfg_get "$INDEX"_guest_ssid_broadcast`
	fi
	if [ "0" = $SSID_BROADCAST ] ; then
		HIDE_SSID=1
	else
		HIDE_SSID=0 
	fi
	set_wifi_val $GUEST_VAP HideSSID $HIDE_SSID
	set_wifi_val $GUEST_VAP SSID "$GUEST_SSID"
	USER_MAC=`syscfg_get ${INDEX}_mac_addr`
	set_wifi_val $GUEST_VAP MacAddress1 `get_guest_mac $USER_MAC`
	return 0
