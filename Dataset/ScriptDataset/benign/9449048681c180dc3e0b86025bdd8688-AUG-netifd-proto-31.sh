	local interface="$1"; shift

	json_init
	json_add_int action 2
	[ -n "$1" ] && json_add_int signal "$1"
	_proto_notify "$interface"
