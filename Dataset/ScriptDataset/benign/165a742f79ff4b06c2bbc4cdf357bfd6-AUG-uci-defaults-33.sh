	local cfg="$1"
	local name="$2"
	local pin="$3"
	local default="${4:-0}"

	json_select_object gpioswitch
		json_select_object "$cfg"
			json_add_string name "$name"
			json_add_int pin "$pin"
			json_add_int default "$default"
		json_select ..
	json_select ..
