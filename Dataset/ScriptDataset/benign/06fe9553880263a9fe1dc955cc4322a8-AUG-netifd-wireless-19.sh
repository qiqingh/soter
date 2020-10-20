	local multicast_to_unicast="$1"
	local isolate

	json_get_var isolate isolate

	[ ${isolate:-0} -gt 0 -o -z "$network_bridge" ] && return
	[ ${multicast_to_unicast:-1} -gt 0 ] && json_add_boolean isolate 1
