	ifconfig "$PHY_IF" down
	ifconfig "$STA_IF" down
	iwpriv "$PHY_IF" bssid "$PHY_IF_MAC"
	iwpriv "$PHY_IF" opmode "$OPMODE"
	iwpriv "$PHY_IF" wmm 1
	iwpriv "$PHY_IF" htbw 0
	iwpriv "$PHY_IF" autochannel 1
	if [ -n "$CHANNEL" ] && [ "0" != "$CHANNEL" ]; then
		iwconfig "$PHY_IF" channel "$CHANNEL" 
	fi
	ifconfig "$PHY_IF" up
	iwpriv "$STA_IF" macclone "0 $STA_MAC"
	iwpriv "$STA_IF" stamode "$STAMODE"
	iwpriv "$STA_IF" ampdutx 1
	iwpriv "$STA_IF" amsdu 1
	iwconfig "$STA_IF" essid "$SSID"
	wifi_sta_set_security "$STA_IF" $SECURITY "$PASSPHRASE"
	echo "${SERVICE_NAME}, attempting to connect $STA_IF to $SSID"
	ifconfig "$STA_IF" up
