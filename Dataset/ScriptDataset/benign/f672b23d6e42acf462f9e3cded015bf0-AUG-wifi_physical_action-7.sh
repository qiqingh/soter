	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, wifi_physical_action_restart(${PHY_IF})"
	wifi_physical_action_stop ${PHY_IF}
	wifi_physical_action_start ${PHY_IF}
