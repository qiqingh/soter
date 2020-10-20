	local port_state="$4"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string trigger port_state
	json_add_string type portstate
	json_add_string port_state "$port_state"
	json_select ..

	json_select ..
