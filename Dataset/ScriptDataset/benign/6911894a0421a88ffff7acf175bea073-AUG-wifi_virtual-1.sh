	ulog wlan status "${SERVICE_NAME}, wifi_virtual_start($1)"
	echo "${SERVICE_NAME}, wifi_virtual_start($1)"
	PHY_IF=$1
	if [ -z "$PHY_IF" ]; then
		echo "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		return 1
	fi
	
	wait_till_end_state ${WIFI_VIRTUAL}_${PHY_IF}
	STATUS=`sysevent get ${WIFI_VIRTUAL}_${PHY_IF}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ] ; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_VIRTUAL} is starting/started, ignore the request"
		return 1
	fi
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	USER_STATE=`syscfg_get ${SYSCFG_INDEX}_state`
	if [ "$USER_STATE" = "down" ]; then
		VIR_IF=`syscfg_get "$SYSCFG_INDEX"_user_vap`
		echo "${SERVICE_NAME}, ${SYSCFG_INDEX}_state=$USER_STATE, do not start virtual $VIR_IF"
		return 1
	fi
	sysevent set ${WIFI_VIRTUAL}_${PHY_IF}-status starting
	wifi_user_start $PHY_IF
	ERR=$?
	if [ "$ERR" = "0" ] ; then
		wifi_simpletap_start $PHY_IF
		wifi_guest_start $PHY_IF
		sysevent set ${WIFI_VIRTUAL}_${PHY_IF}-status started
	else
		sysevent set ${WIFI_VIRTUAL}_${PHY_IF}-status stopped
		check_err $? "Unable to bringup user wifi"
	fi
	return 0
