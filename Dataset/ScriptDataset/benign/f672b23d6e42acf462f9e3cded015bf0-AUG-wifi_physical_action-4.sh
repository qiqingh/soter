	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, wifi_runtime_setting(${PHY_IF})"
	platform_runtime_setting ${PHY_IF}
