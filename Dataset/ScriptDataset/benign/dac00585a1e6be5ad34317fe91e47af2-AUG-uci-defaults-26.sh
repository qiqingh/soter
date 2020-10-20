	local iface="$4"
	local minq="$5"
	local maxq="$6"
	local offset="${7:-0}"
	local factor="${8:-1}"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string type rssi
	json_add_string name "$name"
	json_add_string iface "$iface"
	json_add_string minq "$minq"
	json_add_string maxq "$maxq"
	json_add_string offset "$offset"
	json_add_string factor "$factor"
	json_select ..

	json_select ..
