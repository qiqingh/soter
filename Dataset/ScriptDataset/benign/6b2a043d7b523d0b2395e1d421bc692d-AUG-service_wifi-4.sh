	ulog wlan status "${SERVICE_NAME}, service_stop()"
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "stopped" = "$STATUS" ] || [ "stopping" = "$STATUS" ] || [ -z "$STATUS" ]; then
		echo "${SERVICE_NAME} is stopping/stopped, ignore the request"
		ulog wlan status "${SERVICE_NAME} is stopping/stopped, ignore the request"
		return 1
	fi
	
	echo "${SERVICE_NAME}, service_stop()"
	sysevent set ${SERVICE_NAME}-status stopping
	for PHY_IF in $PHYSICAL_IF_LIST; do
		wifi_virtual_stop $PHY_IF
		stop_hostapd $PHY_IF
		wifi_physical_stop $PHY_IF
	done
	sysevent set ${SERVICE_NAME}-status stopped
	return 0
