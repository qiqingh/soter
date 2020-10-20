	local trigger_name="$4"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string trigger "$trigger_name"
	json_select ..

	json_select ..
