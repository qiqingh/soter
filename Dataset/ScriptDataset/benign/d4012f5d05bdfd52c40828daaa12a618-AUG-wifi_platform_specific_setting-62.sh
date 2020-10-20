	WPS_IF_LIST="$1"
	for i in $WPS_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $i`	
		NVRAM_WL=`get_nvram_index $i`
		SSID=`syscfg get $WL_SYSCFG"_ssid"`
		PASSPHRASE=`syscfg get $WL_SYSCFG"_passphrase"`
		CRYPTO=`syscfg get $WL_SYSCFG"_encryption"`
		WPA_AUTH=`get_wpa_auth $WL_SYSCFG`
		if [ "0" = "$WPA_AUTH" ]; then
			PASSPHRASE=""
			CRYPTO=""
		fi
		case $WPA_AUTH in
			"4")
				AKM="psk "
				;;
			"128")
				AKM="psk2 "
				;;
			"132")
				AKM="psk psk2 "
				;;
			*)
				AKM=""
				;;
		esac
		nvram_set $NVRAM_WL"_ssid" "$SSID"
		nvram_set $NVRAM_WL"_akm" "$AKM"
		nvram_set $NVRAM_WL"_crypto" "$CRYPTO"
		nvram_set $NVRAM_WL"_wpa_psk" "$PASSPHRASE"
	done
	nvram_set wps_status 0
	nvram_set wps_method 1
	nvram_set wps_config_command 0
	nvram_set wps_proc_mac ""
	WPS_RESTART=`nvram get wps_restart`
	if [ "1" = "WPS_RESTART" ]; then
		nvram_set wps_restart 0
	else
		nvram_set wps_restart 0
		nvram_set wps_proc_status 0
	fi
	nvram_set wps_sta_pin "00000000"
	nvram_set wps_currentband ""
	start_driver_wps_process
	return 0
