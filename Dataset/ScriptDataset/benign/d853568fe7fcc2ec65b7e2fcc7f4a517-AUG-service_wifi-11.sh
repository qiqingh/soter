	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, wifi_down($PHY_IF)"
    wifi_sta_stop
	wifi_virtual_stop $PHY_IF
	wifi_physical_stop $PHY_IF
