	ulog wlan status "${SERVICE_NAME}, wifi_physical_start($1)"
	echo "${SERVICE_NAME}, wifi_physical_start($1)"
	PHY_IF=$1
	wait_till_end_state ${WIFI_PHYSICAL}_${PHY_IF}
	STATUS=`sysevent get ${WIFI_PHYSICAL}_${PHY_IF}-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ] ; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_PHYSICAL} is starting/started, ignore the request"
		return 1
	fi
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	USER_STATE=`syscfg_get ${SYSCFG_INDEX}_state`
	if [ "$USER_STATE" = "down" ]; then
		VIR_IF=`syscfg_get "$SYSCFG_INDEX"_user_vap`
		echo "${SERVICE_NAME}, ${SYSCFG_INDEX}_state=$USER_STATE, do not start physical $PHY_IF"
		return 1
	fi
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status starting
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status started
	
	return 0
