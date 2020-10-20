	WPA_AUTH=""
	SYSCFG_SECURITY_MODE=`syscfg get $1_security_mode`
	case "$SYSCFG_SECURITY_MODE" in
	"disabled")
		WPA_AUTH="0"
		;;
	"wep")
		WPA_AUTH="1"
		;;
	"wpa-personal")
		WPA_AUTH="4"
		;;
	"wpa2-personal")
		WPA_AUTH="128"
		;;
	"wpa-mixed")
		WPA_AUTH="132"
		;;
	"wpa-enterprise")
		WPA_AUTH="2"
		;;
	"wpa2-enterprise")
		WPA_AUTH="64"
		;;
	"wpa-enterprise-mixed")
		WPA_AUTH="66"
		;;
	*)
		WPA_AUTH="0"
		;;
	esac
	echo "$WPA_AUTH"	
