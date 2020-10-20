	local obj="$1"
	local name="$2"
	local sysfs="$3"
	shift
	shift
	shift

	json_select_object led

	json_select_object "$obj"
	json_add_string name "$name"
	json_add_string type usbport
	json_add_string sysfs "$sysfs"
	json_select_array ports
		for port in "$@"; do
			json_add_string port "$port"
		done
	json_select ..
	json_select ..

	json_select ..
