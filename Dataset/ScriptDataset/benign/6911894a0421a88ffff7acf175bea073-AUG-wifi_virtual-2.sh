	ulog wlan status "${SERVICE_NAME}, wifi_virtual_stop($1)"
	echo "${SERVICE_NAME}, wifi_virtual_stop($1)"
	PHY_IF=$1
	if [ -z "$PHY_IF" ]; then
		echo "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		return 1
	fi
	wait_till_end_state ${WIFI_VIRTUAL}_${PHY_IF}
	STATUS=`sysevent get ${WIFI_VIRTUAL}_${PHY_IF}-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_VIRTUAL} is already stopping/stopped, ignore the request"
		return 1
	fi
	sysevent set ${WIFI_VIRTUAL}_${PHY_IF}-status stopping
	wifi_guest_stop $PHY_IF
	wifi_simpletap_stop $PHY_IF
	wifi_user_stop $PHY_IF
	ERR=$?
	if [ "$ERR" -ne "0" ] ; then
		check_err $ERR "Unable to teardown user wifi"
	else
		sysevent set ${WIFI_VIRTUAL}-errinfo
		sysevent set ${WIFI_VIRTUAL}_${PHY_IF}-status stopped
	fi
	return 0
