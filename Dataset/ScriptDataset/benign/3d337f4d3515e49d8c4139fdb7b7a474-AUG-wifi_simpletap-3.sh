	wait_till_end_state ${WIFI_SIMPLETAP}
	TAP_CONNECT_ENABLED=`syscfg get tc_vap_enabled`
	if [ "$TAP_CONNECT_ENABLED" = "0" ]; then
		ulog wlan status "${SERVICE_NAME}, simpletap vap is disabled, do not start wifi simpletap"
		return 1
	fi
	if [ "2g" = "`syscfg get wifi_sta_radio`" ] && [ "1" = "`syscfg get wifi_sta_enabled`" ]; then
		ulog wlan status "${SERVICE_NAME}, PSTA mode, do not start wifi simpletap"
		return 1
	fi
	STATUS=`sysevent get ${WIFI_SIMPLETAP}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_SIMPLETAP} is starting/started, ignore the request"
		return 1
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_simpletap_start()"
	sysevent set ${WIFI_SIMPLETAP}-status starting
	start_simpletap
	if [ "$?" = "0" ]; then
		sysevent set ${WIFI_SIMPLETAP}-status started
		return 0
	else	#return 1 means MBSS needs to be created, simpletap is not started yet
		sysevent set ${WIFI_SIMPLETAP}-status stopped
		return 1
	fi
