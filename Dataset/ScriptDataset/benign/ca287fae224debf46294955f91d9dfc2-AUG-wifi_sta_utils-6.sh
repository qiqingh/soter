	INTERFACE=$1
	SYSCFG_SECURITY=`syscfg get wifi_sta_security_mode`
	SELECTED_SSID=`syscfg get wifi_sta_ssid`
	SELECTED_AMODE=""
	SELECTED_ENCRYPTION=""
	SUPPLICANT=""
	case "$SYSCFG_SECURITY" in
		"wpa2-personal")
			SELECTED_SECURITY=0x80
			SELECTED_AMODE="wpa2psk"
			SELECTED_ENCRYPTION=4
			SUPPLICANT=1
			;;
		"wpa-personal")
			SELECTED_SECURITY=0x4
			SELECTED_AMODE="wpapsk"
			SELECTED_ENCRYPTION=6
			SUPPLICANT=1
			;;
		*)
			SELECTED_SECURITY=0x0
			SELECTED_AMODE="open"
			SELECTED_ENCRYPTION=0x0
			SUPPLICANT=0
			;;
	esac
	SELECTED_PASSPHRASE=`syscfg get wifi_sta_passphrase`
	wl -i $INTERFACE up
	wl -i $INTERFACE wpa_auth "$SELECTED_SECURITY"
	wl -i $INTERFACE wsec "$SELECTED_ENCRYPTION"
	if [ "open" != "$SELECTED_AMODE" ]; then
		wl -i $INTERFACE set_pmk "$SELECTED_PASSPHRASE"
		sleep 2
		wl -i $INTERFACE sup_wpa "$SUPPLICANT"
	fi
	wl -i $INTERFACE join $SELECTED_SSID amode $SELECTED_AMODE
	DEBUG echo "Interface $INTERFACE connected" > /dev/console
