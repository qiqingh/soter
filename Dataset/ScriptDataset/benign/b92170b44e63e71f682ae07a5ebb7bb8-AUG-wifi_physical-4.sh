	ulog wlan status "${SERVICE_NAME}, wifi_physical_restart()"
	echo "${SERVICE_NAME}, wifi_physical_restart()"
	for PHY_IF in $PHYSICAL_IF_LIST; do
		wifi_physical_stop $PHY_IF
		wifi_physical_start $PHY_IF
	done
	return 0
