	local package="$1"

	json_init
	json_add_string type config.change
	json_add_object data
	json_add_string package "$package"
	json_close_object

	ubus call service event "$(json_dump)"
