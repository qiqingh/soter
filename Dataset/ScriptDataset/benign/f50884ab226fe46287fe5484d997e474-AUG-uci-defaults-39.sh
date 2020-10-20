	local hostname="$1"

	json_select_object system
		json_add_string hostname "$hostname"
	json_select ..
