	IF=$1
	SECURITY=$2
	PASSPHRASE="$3"
	case "$SECURITY" in
		"wpa-personal")
			iwpriv $IF wpawpa2mode 1
			iwpriv $IF ciphersuite "wpa tkip"
			iwpriv $IF passphrase "wpa $PASSPHRASE"
			;;
		"wpa2-personal")
			iwpriv $IF wpawpa2mode 2
			iwpriv $IF ciphersuite "wpa2 aes-ccmp"
			iwpriv $IF passphrase "wpa2 $PASSPHRASE"
			;;
		"wpa-mixed")
			iwpriv $IF wpawpa2mode 2
			iwpriv $IF ciphersuite "wpa2 aes-ccmp"
			iwpriv $IF passphrase "wpa2 $PASSPHRASE"
			;;
		*)
			iwpriv $IF wpawpa2mode 0
			;;
	esac
