	local interface="$1"; shift

	json_init
	json_add_int action 4
	_proto_notify "$interface"
