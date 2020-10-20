	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local trigger="$4"
	local port_mask="$5"
	local speed_mask="$6"

	json_select_object led

	json_select_object "$1"
	json_add_string name "$name"
	json_add_string type switch
	json_add_string sysfs "$sysfs"
	json_add_string trigger "$trigger"
	json_add_string port_mask "$port_mask"
	json_add_string speed_mask "$speed_mask"
	json_select ..

	json_select ..
