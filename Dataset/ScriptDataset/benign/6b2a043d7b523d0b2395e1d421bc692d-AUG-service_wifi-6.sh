	ONE_TIME=`sysevent get wifi-onetime-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		ulog wlan status "${SERVICE_NAME}, wifi_onetime_setting()"
		sysevent set wifi-onetime-setting "TRUE"
		sysevent set wl0_status "down"
		sysevent set wl0_guest_status "down"
		sysevent set wl0_tc_status "down"
		sysevent set wl1_status "down"
		sysevent set wl1_guest_status "down"
		sysevent set wl1_tc_status "down"	
		load_wifi_driver            
		/etc/init.d/service_wifi/WiFi_info_set.sh &	
		create_files	
	fi
	return 0
