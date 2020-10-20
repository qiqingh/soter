	echo "${SERVICE_NAME}, init()"
	iwpriv $PHY_IF opmode $OPMODE
	iwpriv $PHY_IF wmm 1
	iwpriv $PHY_IF htbw 0
	iwpriv $PHY_IF autochannel 1
	physical_setting $PHY_IF
	ifconfig $PHY_IF up
	iwpriv $VIR_IF ampdutx 1
	iwpriv $VIR_IF amsdu 1
	iwpriv $VIR_IF stamode $STAMODE
	iwconfig $VIR_IF essid "$STA_SSID"
	wifi_sta_set_security $VIR_IF $STA_SECURITY "$STA_PASSPHRASE"
