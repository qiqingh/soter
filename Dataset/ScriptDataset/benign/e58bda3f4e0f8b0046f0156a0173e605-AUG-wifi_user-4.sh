	echo "${SERVICE_NAME}, wifi_user_stop($1)"
	PHY_IF=$1
	wait_till_end_state ${WIFI_USER}_${PHY_IF}
	ulog wlan status "${SERVICE_NAME}, wifi_user_stop($PHY_IF)"
	STATUS=`sysevent get ${WIFI_USER}_${PHY_IF}-status`
	if [ "stopped" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} is already stopping/stopped, ignore the request"
		return 1
	fi
	sysevent set ${WIFI_USER}_${PHY_IF}-status stopping
	user_stop $PHY_IF
	sysevent set ${WIFI_USER}_${PHY_IF}-status stopped
	return 0
