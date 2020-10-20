	wait_till_end_state ${SERVICE_NAME}
	ulog wlan status "${SERVICE_NAME}, service_start()"
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME} is starting/started, ignore the request"
		return 0
	fi
	if [ "0" = "`syscfg get bridge_mode`" ] && [ "started" != "`sysevent get lan-status`" ] ; then
		ulog wlan status "${SERVICE_NAME}, LAN is not started,ignore the request"
		return 0
	fi
	if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_sta_setup.sh ] ; then
		/etc/init.d/service_wifi/wifi_sta_setup.sh
	fi
	source /etc/init.d/service_wifi/wifi_utils.sh
	echo "${SERVICE_NAME}, service_start()"
	sysevent set WIFI_START_NEED "1"
	wifi_config_changed_handler
