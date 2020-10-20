	local respawn_vals
	_json_no_warning=1
	if json_select respawn ; then
		json_get_values respawn_vals
		if [ -z "$respawn_vals" ]; then
			local respawn_retry=$(uci_get system.@service[0].respawn_retry)
			_procd_add_array_data 3600 5 ${respawn_retry:-5}
		fi
		json_select ..
	fi

	json_close_object
