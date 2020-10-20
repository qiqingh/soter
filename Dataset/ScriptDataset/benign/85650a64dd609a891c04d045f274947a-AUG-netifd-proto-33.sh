	local interface="$1"; shift

	json_init
	json_add_int action 1
	json_add_array command
	while [ $# -gt 0 ]; do
		json_add_string "" "$1"
		shift
	done
	json_close_array
	[ -n "$_EXPORT_VARS" ] && {
		json_add_array env
		for var in $_EXPORT_VARS; do
			eval "json_add_string \"\" \"\${$var}\""
		done
		json_close_array
	}
	_proto_notify "$interface"
