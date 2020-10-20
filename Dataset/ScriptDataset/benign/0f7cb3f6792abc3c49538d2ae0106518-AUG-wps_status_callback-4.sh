	SEC=$1
	case "$SEC" in
		OPEN)
			SYSCFG_SEC="disabled"
			;;
		WEPAUTO)
			SYSCFG_SEC="wep"
			;;
		WPAPSK)
			SYSCFG_SEC="wpa-personal"
			;;
		WPA)
			SYSCFG_SEC="wpa-enterprise"
			;;
		WPA2PSK)
			SYSCFG_SEC="wpa2-personal"
			;;
		WPA2)
			SYSCFG_SEC="wpa2-enterprise"
			;;
		WPAPSKWPA2PSK)
			SYSCFG_SEC="wpa-mixed"
			;;
		WPA1WPA2)
			SYSCFG_SEC="wpa-enterprise-mixed"
			;;
		*)
			echo "	wifi, $PHY_IF wps_status_callback: invalid wps_cred security $SEC"
			exit 3
			;;
	esac
