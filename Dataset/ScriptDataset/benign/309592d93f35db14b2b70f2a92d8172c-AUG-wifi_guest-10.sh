	ulog wlan status "${SERVICE_NAME}, wifi_guest_restart()"
	wifi_guest_stop
	wifi_guest_start
	return 0
