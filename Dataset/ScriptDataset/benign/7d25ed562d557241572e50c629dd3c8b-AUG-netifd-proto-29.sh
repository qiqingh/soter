	local interface="$1"
	local options="$2"
	json_add_string "interface" "$interface"
	ubus $options call network.interface notify_proto "$(json_dump)"
