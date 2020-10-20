	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	VIR_IF=`syscfg_get "$SYSCFG_INDEX"_user_vap`
	
	if [ "true" = "$RECONFIGURE" ]; then
		return 1
	fi
	
	USER_STATE=`syscfg_get ${SYSCFG_INDEX}_state`
	if [ "down" = "$USER_STATE" ]; then
		return 1
	fi
	REPEATER_DISABLED=`syscfg_get repeater_disabled`
	if [ ! -z "$REPEATER_DISABLED" ] && [ "1" = "$REPEATER_DISABLED" ]; then
		syscfg_set ${SYSCFG_INDEX}_state "down"
		return 1
	fi
	LAN_IFNAME=`syscfg_get lan_ifname`
	unsecure_page
	RET_CODE="0"
	if [ "true" = "$RECONFIGURE" ]; then
		ulog wlan status "$VIR_IF is preparing to reconfigure due to incompatible mode"
		RET_CODE="2"
	else
		RET_CODE="0"
	fi
	return $RET_CODE
