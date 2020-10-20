	echo "${SERVICE_NAME}, wifi_user_start($1)"
	PHY_IF=$1
	wait_till_end_state ${WIFI_USER}_${PHY_IF}
	ulog wlan status "${SERVICE_NAME}, wifi_user_start($PHY_IF)"
	STATUS=`sysevent get ${WIFI_USER}_${PHY_IF}-status`
	if [ "started" = "$STATUS" ] ; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} is starting/started, ignore the request"
		return 1
	fi
	sysevent set ${WIFI_USER}_${PHY_IF}-status starting
	user_start $PHY_IF
	RET_CODE=$?
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	USER_STATE=`syscfg_get ${SYSCFG_INDEX}_state`
	if [ "down" = "$USER_STATE" ]; then
		sysevent set ${WIFI_USER}_${PHY_IF}-status stopped
	else
		sysevent set ${WIFI_USER}_${PHY_IF}-status started
	fi
	return $RET_CODE
