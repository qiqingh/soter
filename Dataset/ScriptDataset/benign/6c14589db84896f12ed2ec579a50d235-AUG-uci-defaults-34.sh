	local obj="$1"
	local name="$2"
	local sysfs="$3"
	shift
	shift
	shift

	_ucidef_set_led_common "$obj" "$name" "$sysfs"

	json_add_string type usbport
	json_select_array ports
		for port in "$@"; do
			json_add_string port "$port"
		done
	json_select ..
	json_select ..

	json_select ..
