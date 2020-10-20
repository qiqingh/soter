	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, wifi_config($PHY_IF)"
	wifi_physical_config $PHY_IF
	wifi_virtual_config $PHY_IF
	create_wifi_cfg $PHY_IF
	
