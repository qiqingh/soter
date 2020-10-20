	json_get_vars encryption
	set_default encryption none

	auth_mode_open=1
	auth_mode_shared=0
	auth_type=none
	wpa_cipher=CCMP
	case "$encryption" in
		*tkip+aes|*tkip+ccmp|*aes+tkip|*ccmp+tkip) wpa_cipher="CCMP TKIP";;
		*aes|*ccmp) wpa_cipher="CCMP";;
		*tkip) wpa_cipher="TKIP";;
	esac

	# 802.11n requires CCMP for WPA
	[ "$enable_ht:$wpa_cipher" = "1:TKIP" ] && wpa_cipher="CCMP TKIP"

	# Examples:
	# psk-mixed/tkip    => WPA1+2 PSK, TKIP
	# wpa-psk2/tkip+aes => WPA2 PSK, CCMP+TKIP
	# wpa2/tkip+aes     => WPA2 RADIUS, CCMP+TKIP

	case "$encryption" in
		wpa2*|*psk2*)
			wpa=2
		;;
		*mixed*)
			wpa=3
		;;
		wpa*|*psk*)
			wpa=1
		;;
		*)
			wpa=0
			wpa_cipher=
		;;
	esac
	wpa_pairwise="$wpa_cipher"

	case "$encryption" in
		*psk*)
			auth_type=psk
		;;
		*wpa*|*8021x*)
			auth_type=eap
		;;
		*wep*)
			auth_type=wep
			case "$encryption" in
				*shared*)
					auth_mode_open=0
					auth_mode_shared=1
				;;
				*mixed*)
					auth_mode_shared=1
				;;
			esac
		;;
	esac
