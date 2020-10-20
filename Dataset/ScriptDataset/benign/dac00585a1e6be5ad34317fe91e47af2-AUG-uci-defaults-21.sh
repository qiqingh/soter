	local gpio="$4"
	local inverted="$5"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string trigger "$trigger"
	json_add_string type gpio
	json_add_int gpio "$gpio"
	json_add_boolean inverted "$inverted"
	json_select ..

	json_select ..
