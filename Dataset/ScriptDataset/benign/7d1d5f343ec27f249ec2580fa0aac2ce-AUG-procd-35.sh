	procd_open_data
	json_add_object "mdns"
	procd_add_mdns_service $@
	json_close_object
	procd_close_data
