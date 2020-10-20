	ONE_TIME=`sysevent get wifi-onetime-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		ulog wlan status "${SERVICE_NAME}, wifi_onetime_setting()"
		echo "${SERVICE_NAME}, wifi_onetime_setting"
		sysevent set wifi-onetime-setting "TRUE"
		load_wifi_driver
		RET_VAL=$?
		if [ "$RET_VAL" = 1 ]; then
			ulog wlan status "${SERVICE_NAME}, ERROR! unable to load wifi driver"
			exit
		fi
        WiFi_info_restore
		create_files	
	fi
	return 0
