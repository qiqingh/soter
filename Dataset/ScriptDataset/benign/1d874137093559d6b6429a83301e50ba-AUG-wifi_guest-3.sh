	PHY_IF=$1
	echo "${SERVICE_NAME}, wifi_guest_restart($PHY_IF)"
	wifi_guest_stop $PHY_IF
	wifi_guest_start $PHY_IF
	return 0
