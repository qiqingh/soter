	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local trigger="$4"
	local delayon="$5"
	local delayoff="$6"

	json_select_object led

	json_select_object "$1"
	json_add_string type "$trigger"
	json_add_string name "$name"
	json_add_string sysfs "$sysfs"
	json_add_int delayon "$delayon"
	json_add_int delayoff "$delayoff"
	json_select ..

	json_select ..
