	local annex="$1"
	local firmware="$2"

	json_select_object dsl
		json_select_object modem
			json_add_string type "adsl"
			json_add_string annex "$annex"
			json_add_string firmware "$firmware"
		json_select ..
	json_select ..
