	WL_SYSCFG_0=`get_syscfg_interface_name eth1`
	WL_SYSCFG_1=`get_syscfg_interface_name eth2`
	WL_SYSCFG_2=`get_syscfg_interface_name eth3`
	USR_SSID_0=`syscfg get ${WL_SYSCFG_1}_ssid`
	NEW_SSID_0=`nvram get wl1_ssid`
	USR_SSID_1=`syscfg get ${WL_SYSCFG_0}_ssid`
	NEW_SSID_1=`nvram get wl0_ssid`
	USR_SSID_2=`syscfg get ${WL_SYSCFG_2}_ssid`
	NEW_SSID_2=`nvram get wl2_ssid`
	if [ "$USR_SSID_0" != "$NEW_SSID_0" ] ; then
		NEW_SSID=`nvram get wl1_ssid`
		NEW_WPA_PSK=`nvram get wl1_wpa_psk`
		NEW_CRYPTO=`nvram get wl1_crypto`
		NEW_AKM=`nvram get wl1_akm`
	elif [ "$USR_SSID_1" != "$NEW_SSID_1" ] ; then
		NEW_SSID=`nvram get wl0_ssid`
		NEW_WPA_PSK=`nvram get wl0_wpa_psk`
		NEW_CRYPTO=`nvram get wl0_crypto`
		NEW_AKM=`nvram get wl0_akm`
	elif [ "$USR_SSID_2" != "$NEW_SSID_2" ] ; then
		NEW_SSID=`nvram get wl2_ssid`
		NEW_WPA_PSK=`nvram get wl2_wpa_psk`
		NEW_CRYPTO=`nvram get wl2_crypto`
		NEW_AKM=`nvram get wl2_akm`
	else
		echo "no new settings" > /dev/console
		return 0
	fi
	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		syscfg_set $WL_SYSCFG"_ssid" "$NEW_SSID"
		syscfg_set $WL_SYSCFG"_passphrase" "$NEW_WPA_PSK"
		syscfg_set $WL_SYSCFG"_encryption" "$NEW_CRYPTO"
		case "$NEW_AKM" in
			"psk ")
				syscfg_set $WL_SYSCFG"_security_mode" "wpa-personal"
			;;
			"psk2 ")
				syscfg_set $WL_SYSCFG"_security_mode" "wpa2-personal"
			;;
			"psk psk2 ")
				syscfg_set $WL_SYSCFG"_security_mode" "wpa-mixed"
			;;
		*)
			echo "Invalid security mode from nvram" > /dev/console
			syscfg_set $WL_SYSCFG"_security_mode" "disabled"
			;;
		esac
	done
