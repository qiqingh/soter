	local options="$1"

	json_close_object
	ubus $options call network.wireless notify "$(json_dump)"
