	ulog wlan status "${SERVICE_NAME}, wifi_virtual_restart()"
	echo "${SERVICE_NAME}, wifi_virtual_restart()"
	for PHY_IF in $PHYSICAL_IF_LIST; do
		wifi_virtual_stop $PHY_IF
		wifi_virtual_start $PHY_IF
	done
	return 0
