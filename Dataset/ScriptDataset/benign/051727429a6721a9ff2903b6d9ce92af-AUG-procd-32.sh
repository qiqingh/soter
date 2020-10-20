	local service="$1"
	local instance="${2:-instance1}"
	local running

	json_init
	json_add_string name "$service"
	running=$(_procd_ubus_call list | jsonfilter -e "@.$service.instances.${instance}.running")

	[ "$running" = "true" ]
