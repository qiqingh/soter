	local command="$1"
	local interface="$2"

	json_init
	json_add_int "command" "$command"
	json_add_string "device" "$__netifd_device"
	[ -n "$interface" ] && json_add_string "interface" "$interface"
	json_add_object "data"
