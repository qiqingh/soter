	local cfg="led_$1"
	local name="$2"
	local sysfs="$3"
	local port_state="$4"

	json_select_object led

	json_select_object "$1"
	json_add_string name "$name"
	json_add_string type portstate
	json_add_string sysfs "$sysfs"
	json_add_string trigger port_state
	json_add_string port_state "$port_state"
	json_select ..

	json_select ..
