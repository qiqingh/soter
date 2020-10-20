	local service="$1"
	local instance="$2"

	json_init
	[ -n "$service" ] && json_add_string name "$service"
	[ -n "$instance" ] && json_add_string instance "$instance"
	_procd_ubus_call delete
