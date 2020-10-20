	ulog wlan status "${SERVICE_NAME}, wifi_wl1_guest_restart()"
	wifi_wl1_guest_stop
	wifi_wl1_guest_start
	return 0
