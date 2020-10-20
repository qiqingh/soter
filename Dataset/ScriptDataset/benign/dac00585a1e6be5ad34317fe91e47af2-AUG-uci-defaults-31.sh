	local dev="$4"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string type usb
	json_add_string device "$dev"
	json_select ..

	json_select ..
