	ulog wlan status "${SERVICE_NAME}, wifi_physical_start($1)"
	echo "${SERVICE_NAME}, wifi_physical_start($1)"
	PHY_IF=$1
	if [ -z "$PHY_IF" ]; then
		echo "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		return 1
	fi
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
	STA_PHY_IF=`syscfg_get wifi_sta_phy_if`
	if [ "2" = "`syscfg_get wifi_bridge::mode`" ] && [ "$PHY_IF" = "$STA_PHY_IF" ]; then
		echo "${SERVICE_NAME}, $PHY_IF is in repeater mode, do not start physical again"
		return 1
	fi
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status starting
	physical_pre_setting $PHY_IF
	
	physical_setting $PHY_IF
	
	physical_post_setting $PHY_IF
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status started
	
	return 0
