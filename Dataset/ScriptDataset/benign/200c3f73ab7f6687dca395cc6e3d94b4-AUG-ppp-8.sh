	local config="$1"

	json_get_var device device
	ppp_generic_setup "$config" "$device"
