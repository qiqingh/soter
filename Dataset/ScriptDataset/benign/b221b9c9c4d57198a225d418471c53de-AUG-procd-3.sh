	local cmd="$1"

	[ -n "$PROCD_DEBUG" ] && json_dump >&2
	ubus call service "$cmd" "$(json_dump)"
	json_cleanup
