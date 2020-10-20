	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local dev="$4"
	local mode="${5:-link tx rx}"

	json_select_object led

	json_select_object "$1"
	json_add_string name "$name"
	json_add_string type netdev
	json_add_string sysfs "$sysfs"
	json_add_string device "$dev"
	json_add_string mode "$mode"
	json_select ..

	json_select ..
