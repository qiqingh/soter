	ulog wlan status "${SERVICE_NAME}, wifi_wl0_guest_restart()"
	wifi_wl0_guest_stop
	wifi_wl0_guest_start
	return 0
