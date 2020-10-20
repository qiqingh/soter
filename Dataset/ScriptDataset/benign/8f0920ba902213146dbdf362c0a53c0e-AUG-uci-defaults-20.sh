	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local dev="$4"

	json_select_object led

	json_select_object "$1"
	json_add_string name "$name"
	json_add_string type usb
	json_add_string sysfs "$sysfs"
	json_add_string device "$dev"
	json_select ..

	json_select ..
