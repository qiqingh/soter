	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local iface="$4"
	local minq="$5"
	local maxq="$6"
	local offset="$7"
	local factor="$8"

	json_select_object led

	json_select_object "$1"
	json_add_string type rssi
	json_add_string name "$name"
	json_add_string iface "$iface"
	json_add_string sysfs "$sysfs"
	json_add_string minq "$minq"
	json_add_string maxq "$maxq"
	json_add_string offset "$offset"
	json_add_string factor "$factor"
	json_select ..

	json_select ..
