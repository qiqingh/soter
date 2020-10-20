	ulog wlan status "${SERVICE_NAME}, ${VIRTUAL_ACTION}, stop_sub_components()"
	wifi_wl0_guest_stop
	wifi_wl1_guest_stop
	wifi_simpletap_stop
