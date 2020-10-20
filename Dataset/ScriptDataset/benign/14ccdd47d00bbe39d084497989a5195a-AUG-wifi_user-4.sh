	wait_till_end_state ${WIFI_USER}
	STATUS=`sysevent get ${WIFI_USER}-status`
	if [ "started" = "$STATUS" ] ; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} is starting/started, ignore the request"
		return 1
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_user_start()"
	sysevent set ${WIFI_USER}-status starting
	start_user
	sysevent set ${WIFI_USER}-status started
	return 0
