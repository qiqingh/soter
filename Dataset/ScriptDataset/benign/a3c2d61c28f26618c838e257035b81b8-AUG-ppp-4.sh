	proto_config_add_string username
	proto_config_add_string password
	proto_config_add_string keepalive
	proto_config_add_boolean keepalive_adaptive
	proto_config_add_int demand
	proto_config_add_string pppd_options
	proto_config_add_string 'connect:file'
	proto_config_add_string 'disconnect:file'
	[ -e /proc/sys/net/ipv6 ] && proto_config_add_string ipv6
	proto_config_add_boolean authfail
	proto_config_add_int mtu
	proto_config_add_string pppname
	proto_config_add_string unnumbered
	proto_config_add_boolean persist
	proto_config_add_int maxfail
	proto_config_add_int holdoff
