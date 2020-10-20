	no_device=1
	available=1

	proto_config_add_string "rule"
	proto_config_add_string "ipaddr"
	proto_config_add_int "ip4prefixlen"
	proto_config_add_string "ip6prefix"
	proto_config_add_int "ip6prefixlen"
	proto_config_add_string "peeraddr"
	proto_config_add_int "psidlen"
	proto_config_add_int "psid"
	proto_config_add_int "offset"

	proto_config_add_string "tunlink"
	proto_config_add_int "mtu"
	proto_config_add_int "ttl"
	proto_config_add_string "zone"
