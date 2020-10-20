	proto_config_add_string "username"
	proto_config_add_string "password"
	proto_config_add_string "keepalive"
	proto_config_add_string "pppd_options"
	proto_config_add_boolean "ipv6"
	proto_config_add_int "demand"
	proto_config_add_int "mtu"
	proto_config_add_int "checkup_interval"
	proto_config_add_string "server"
	available=1
	no_device=1
	no_proto_task=1
	teardown_on_l3_link_down=1
