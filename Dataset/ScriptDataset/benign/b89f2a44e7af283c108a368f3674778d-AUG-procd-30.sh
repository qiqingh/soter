	local service="$1"
	local instance="$2"
	local signal="$3"

	json_init
	json_add_string name "$service"
	[ -n "$instance" -a "$instance" != "*" ] && json_add_string instance "$instance"
	[ -n "$signal" ] && json_add_int signal "$signal"
	_procd_ubus_call signal
