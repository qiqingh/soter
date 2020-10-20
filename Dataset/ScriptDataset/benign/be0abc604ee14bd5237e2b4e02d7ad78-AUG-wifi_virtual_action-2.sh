	ulog wlan status "${SERVICE_NAME}, ${VIRTUAL_ACTION}, start_sub_components()"
	wifi_simpletap_start
	wifi_wl0_guest_start
	wifi_wl1_guest_start
