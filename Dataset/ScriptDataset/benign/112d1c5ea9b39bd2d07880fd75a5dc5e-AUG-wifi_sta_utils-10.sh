	IF=$1
	SECURITY=$2
	PASSPHRASE="$3"
	case "$SECURITY" in
		"wpa-personal")
            iwpriv $IF set ApCliAuthMode=WPAPSK
            iwpriv $IF set ApCliEncrypType=TKIP
            iwpriv $IF set ApCliWPAPSK="$PASSPHRASE"
			;;
		"wpa2-personal")
            iwpriv $IF set ApCliAuthMode=WPA2PSK
            iwpriv $IF set ApCliEncrypType=AES
            iwpriv $IF set ApCliWPAPSK="$PASSPHRASE"
			;;
		"wpa-mixed")
            iwpriv $IF set ApCliAuthMode=WPAPSKWPA2PSK
            iwpriv $IF set ApCliEncrypType=TKIPAES
            iwpriv $IF set ApCliWPAPSK="$PASSPHRASE"
			;;
		*)
            iwpriv $IF set ApCliAuthMode=OPEN
            iwpriv $IF set ApCliEncrypType=NONE
			;;
	esac
