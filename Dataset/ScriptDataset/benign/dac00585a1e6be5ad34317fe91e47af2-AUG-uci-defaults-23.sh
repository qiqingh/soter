	local dev="$4"
	local mode="${5:-link tx rx}"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string type netdev
	json_add_string device "$dev"
	json_add_string mode "$mode"
	json_select ..

	json_select ..
