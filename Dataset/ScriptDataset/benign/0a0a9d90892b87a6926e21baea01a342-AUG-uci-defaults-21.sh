	local default="$4"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string default "$default"
	json_select ..

	json_select ..
