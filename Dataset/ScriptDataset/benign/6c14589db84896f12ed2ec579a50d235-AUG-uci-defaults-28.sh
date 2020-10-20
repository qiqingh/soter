	local trigger_name="$4"
	local port_mask="$5"
	local speed_mask="$6"
	local mode="$7"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string trigger "$trigger_name"
	json_add_string type switch
	json_add_string mode "$mode"
	json_add_string port_mask "$port_mask"
	json_add_string speed_mask "$speed_mask"
	json_select ..

	json_select ..
