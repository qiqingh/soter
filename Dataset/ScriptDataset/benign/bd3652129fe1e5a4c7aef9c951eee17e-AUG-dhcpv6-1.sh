	renew_handler=1

	proto_config_add_string 'reqaddress:or("try","force","none")'
	proto_config_add_string 'reqprefix:or("auto","no",range(0, 64))'
	proto_config_add_string clientid
	proto_config_add_string 'reqopts:list(uinteger)'
	proto_config_add_string 'defaultreqopts:bool'
	proto_config_add_string 'noslaaconly:bool'
	proto_config_add_string 'forceprefix:bool'
	proto_config_add_string 'extendprefix:bool'
	proto_config_add_string 'norelease:bool'
	proto_config_add_string 'noserverunicast:bool'
	proto_config_add_string 'noclientfqdn:bool'
	proto_config_add_string 'noacceptreconfig:bool'
	proto_config_add_array 'ip6prefix:list(ip6addr)'
	proto_config_add_string iface_dslite
	proto_config_add_string zone_dslite
	proto_config_add_string encaplimit_dslite
	proto_config_add_string iface_map
	proto_config_add_string zone_map
	proto_config_add_string encaplimit_map
	proto_config_add_string iface_464xlat
	proto_config_add_string zone_464xlat
	proto_config_add_string zone
	proto_config_add_string 'ifaceid:ip6addr'
	proto_config_add_string "userclass"
	proto_config_add_string "vendorclass"
	proto_config_add_array "sendopts:list(string)"
	proto_config_add_boolean delegate
	proto_config_add_int "soltimeout"
	proto_config_add_boolean fakeroutes
	proto_config_add_boolean sourcefilter
	proto_config_add_boolean keep_ra_dnslifetime
	proto_config_add_int "ra_holdoff"
