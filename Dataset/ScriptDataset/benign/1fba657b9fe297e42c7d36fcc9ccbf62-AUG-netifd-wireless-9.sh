	local command="$1"
	local name="$2"
	local value="$3"

	json_init
	json_add_int "command" "$command"
	json_add_string "device" "$__netifd_device"
	[ -n "$name" -a -n "$value" ] && json_add_string "$name" "$value"
	json_add_object "data"
