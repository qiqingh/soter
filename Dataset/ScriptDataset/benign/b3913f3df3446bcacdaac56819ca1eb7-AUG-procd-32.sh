	local service="$1"
	local instance="${2:-*}"
	[ "$instance" = "*" ] || instance="'$instance'"

	json_init
	json_add_string name "$service"
	local running=$(_procd_ubus_call list | jsonfilter -l 1 -e "@['$service'].instances[$instance].running")

	[ "$running" = "true" ]
