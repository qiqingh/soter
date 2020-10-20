	STA_NAME="$SELECTED_STA_IF"
	SSID=`syscfg get wifi_sta_ssid`
	if [ "eth1" = "$STA_NAME" ] || [ "eth2" = "$STA_NAME" ]; then
		return
	fi
	STATUS=$FALSE
	STA_IF=""
	STA_IF=`radio_to_brcm_physical_ifname $SELECTED_RADIO`
	STA_NVRAM_IF=wl`radio_to_brcm_wl_index $SELECTED_RADIO`
	ORG_IFS="eth1 eth2"
	NEW_IFS=`echo $ORG_IFS | sed 's/'"${STA_IF}"'//g'`
	syscfg set lan_wl_physical_ifnames "$NEW_IFS"
	syscfg set wifi_sta_user_vap $STA_IF
	syscfg set wifi_sta_nvram_ifname $STA_NVRAM_IF
	WSEC=`get_wsec wifi_sta`
	WPA_AUTH=`get_wpa_auth wifi_sta`
	syscfg set wifi_sta_wpa_auth $WPA_AUTH
 	if [ -n "$WSEC" ]; then
		syscfg set wifi_sta_wsec $WSEC
	fi
	syscfg set wifi_sta_key_renewal 3600
	syscfg commit
	SELECTED_STA_IF="$STA_IF"
	return $TRUE
