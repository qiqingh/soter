	local network=$1
	local macaddr=$2

	json_select_object network

	json_select $network
	[ $? -eq 0 ] || {
		json_select ..
		return
	}

	json_add_string macaddr $macaddr
	json_select ..
	
	json_select ..
