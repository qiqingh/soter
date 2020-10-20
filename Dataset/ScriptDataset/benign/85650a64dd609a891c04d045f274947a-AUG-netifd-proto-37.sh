	local interface="$1"
	local state="$2"
	json_init
	json_add_int action 5
	json_add_boolean available "$state"
	_proto_notify "$interface"
