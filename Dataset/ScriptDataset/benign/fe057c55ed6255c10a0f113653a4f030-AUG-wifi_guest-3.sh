	PHY_IF=$1
	wait_till_end_state ${WIFI_GUEST}
	ulog wlan status "${SERVICE_NAME}, wifi_guest_stop($PHY_IF)"
	echo "${SERVICE_NAME}, wifi_guest_stop($PHY_IF)"
	STATUS=`sysevent get "$WIFI_GUEST"_"$PHY_IF"-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_GUEST} $PHY_IF is already stopping/stopped, ignore the request"
		return 1
	fi
	sysevent set "$WIFI_GUEST"_"$PHY_IF"-status stopping
	guest_stop $PHY_IF
	sysevent set "$WIFI_GUEST"_"$PHY_IF"-status stopped
	return 0
