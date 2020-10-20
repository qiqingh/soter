	local server

	json_select_object system
		json_select_array ntpserver
			for server in "$@"; do
				json_add_string "" "$server"
			done
		json_select ..
	json_select ..
