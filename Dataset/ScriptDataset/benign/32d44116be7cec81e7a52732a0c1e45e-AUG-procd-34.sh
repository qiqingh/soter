	local service proto port
	service=$1; shift
	proto=$1; shift
	port=$1; shift
	json_add_object "${service}_$port"
	json_add_string "service" "_$service._$proto.local"
	json_add_int port "$port"
	[ -n "$1" ] && {
		json_add_array txt
		for txt in "$@"; do json_add_string "" "$txt"; done
		json_select ..
	}
	json_select ..
