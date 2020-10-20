	wait_till_end_state ${WIFI_SIMPLETAP}
	STATUS=`sysevent get ${WIFI_SIMPLETAP}-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_SIMPLETAP} is already stopping/stopped, ignore the request"
		return 0
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_simpletap_stop()"
	sysevent set ${WIFI_SIMPLETAP}-status stopping
	stop_simpletap
	sysevent set ${WIFI_SIMPLETAP}-status stopped
	return 0
