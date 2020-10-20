	config_add_string 'auth_server:host'
	config_add_string auth_secret
	config_add_int 'auth_port:port'

	config_add_int wpa_group_rekey
	config_add_string apname mode ssid encryption key key1 key2 key3 key4 wps_pushbutton macfilter
	config_add_boolean hidden isolate
	config_add_array 'maclist:list(macaddr)'
