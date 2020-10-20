	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local gpio="$4"
	local inverted="$5"

	json_select_object led

	json_select_object "$1"
	json_add_string type gpio
	json_add_string name "$name"
	json_add_string sysfs "$sysfs"
	json_add_string trigger "$trigger"
	json_add_int gpio "$gpio"
	json_add_boolean inverted "$inverted"
	json_select ..

	json_select ..
