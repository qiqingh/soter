	WSEC="0"
	ENC_MODE=`syscfg get $1_encryption`
	SEC_TYPE=`syscfg get $1_security_mode`
	if [ -z "$ENC_MODE" ]; then
		case "$SEC_TYPE" in 
			"wpa-mixed")
				WSEC="6"
				;;
			"wpa2-personal")
				WSEC="4"
				;;
			"wpa-personal")
				WSEC="6"
				;;
		esac
	elif [ "disabled" != "$SEC_TYPE" ]; then
		case "$ENC_MODE" in
			"aes")
				WSEC="4"
				;;
			"tkip")
				WSEC="2"
				;;
			"tkip+aes")
				WSEC="6"
				;;
			"wep")
				WSEC="1"
				;;
			"wep-auto")
				WSEC="1"
				;;
			"wep-open")
				WSEC="1"
				;;
			"wep-shared")
				WSEC="1"
				;;
		esac
	fi
	echo "$WSEC"	
