	echo "${SERVICE_NAME}, connect()"
	ifconfig $PHY_IF up
	sleep 1
	echo "$SERVICE_NAME, bring up STA vap $STA_IF"
	ifconfig $STA_IF up
    iwpriv $STA_IF set MACRepeaterEn=1
    iwpriv $STA_IF set ApCliEnable=0
    iwpriv $STA_IF set ApCliSsid="$SSID"
    iwpriv $STA_IF set ApCliBssid=
	wifi_sta_set_security "$STA_IF" $SECURITY "$PASSPHRASE"
    iwpriv $STA_IF set ApCliSsid="$SSID"
    iwpriv $STA_IF set ApCliAutoConnect=1
    iwpriv $STA_IF set ApCliEnable=1
