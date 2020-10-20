	local service="$1"
	local instance="$2"
	local data

	json_init
	[ -n "$service" ] && json_add_string name "$service"

	data=$(_procd_ubus_call list | jsonfilter -e '@["'"$service"'"]')
	[ -z "$data" ] && { echo "inactive"; return 3; }

	data=$(echo "$data" | jsonfilter -e '$.instances')
	if [ -z "$data" ]; then
		[ -z "$instance" ] && { echo "active with no instances"; return 0; }
		data="[]"
	fi

	[ -n "$instance" ] && instance="\"$instance\"" || instance='*'
	if [ -z "$(echo "$data" | jsonfilter -e '$['"$instance"']')" ]; then
		echo "unknown instance $instance"; return 4
	else
		echo "running"; return 0
	fi
