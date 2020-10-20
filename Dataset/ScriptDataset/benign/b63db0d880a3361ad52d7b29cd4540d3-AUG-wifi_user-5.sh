	wait_till_end_state ${WIFI_USER}
	STATUS=`sysevent get ${WIFI_USER}-status`
	if [ "stopped" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} is already stopping/stopped, ignore the request"
		return 0
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_user_stop()"
	sysevent set ${WIFI_USER}-status stopping
	stop_user
	sysevent set ${WIFI_USER}-status stopped
	return 0
