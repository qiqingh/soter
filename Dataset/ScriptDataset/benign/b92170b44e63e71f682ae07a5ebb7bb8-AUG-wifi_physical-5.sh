	ulog wlan status "${SERVICE_NAME}, physical_pre_setting($1)"
	PHY_IF=$1
	initialize_physical_station $PHY_IF
	return 0
