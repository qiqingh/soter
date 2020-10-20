	local interface="$1"; shift

	json_init
	json_add_int action 3
	json_add_array error
	while [ $# -gt 0 ]; do
		json_add_string "" "$1"
		shift
	done
	json_close_array
	_proto_notify "$interface"
