	local interface="$1"
	json_init
	json_add_int action 7
	_proto_notify "$interface"
