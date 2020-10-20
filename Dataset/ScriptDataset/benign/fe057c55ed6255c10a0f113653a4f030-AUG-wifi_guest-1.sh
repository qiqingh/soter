	PHY_IF=$1
	wait_till_end_state ${WIFI_GUEST}
	ulog wlan status "${SERVICE_NAME}, wifi_guest_start($PHY_IF)"
	echo "${SERVICE_NAME}, wifi_guest_start($PHY_IF)"
	REPEATER_DISABLED=`syscfg_get repeater_disabled`
	if [ -n "$REPEATER_DISABLED" ] && [ "1" = "$REPEATER_DISABLED" ]; then
		ulog guest status "${SERVICE_NAME}, Repeater disabled. service not start"
		sysevent set ${WIFI_GUEST}-errinfo "Repeater disabled. service not started"
		sysevent set ${WIFI_GUEST}-status stopped
		return 1
	fi
	BRIDGE_MODE=`syscfg_get bridge_mode`
	if [ "$BRIDGE_MODE" != "0" ]; then
		echo "${SERVICE_NAME}, Do not start guest network in bridge mode"
		return 1
	fi
	if [ ! -z "$SYSCFG_extender_radio_mode" -a "1" = "$SYSCFG_extender_radio_mode" ] ; then
		echo "${SERVICE_NAME}, guest is not supported on 5GHz wifi Extender" > /dev/console
		return 1
	fi
	INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$INDEX"_guest_vap`
	GUEST_ENABLED=`syscfg_get "$INDEX"_guest_enabled`
	USER_STATE=`syscfg_get "$INDEX"_state`
	MAIN_GUEST_ENABLED=`syscfg_get guest_enabled`
	if [ -z $GUEST_VAP ]; then
		ulog wlan status "${SERVICE_NAME}, guest vap is empty, do not start wifi guest"
		return 1
	fi
	if [ "$GUEST_ENABLED" = "0" ] || [ "$USER_STATE" = "down" ] || [ "$MAIN_GUEST_ENABLED" = "0" ] ; then
		echo "${SERVICE_NAME}, guest or user vap is disabled, do not start wifi guest $GUEST_VAP"
		ulog wlan status "${SERVICE_NAME}, guest vap is disabled, do not start wifi guest $GUEST_VAP"
		return 1
	fi
	STATUS=`sysevent get "$WIFI_GUEST"_"$PHY_IF"-status`
	if [ "started" = "$STATUS" ] || [ "starting" = "$STATUS" ] ; then
		echo "${SERVICE_NAME}, ${WIFI_GUEST} is starting/started, ignore the request"
		ulog wlan status "${SERVICE_NAME}, ${WIFI_GUEST} is starting/started, ignore the request"
		return 1
	fi
	sysevent set "$WIFI_GUEST"_"$PHY_IF"-status starting
	guest_start $PHY_IF
	sysevent set "$WIFI_GUEST"_"$PHY_IF"-status started
	return 0
