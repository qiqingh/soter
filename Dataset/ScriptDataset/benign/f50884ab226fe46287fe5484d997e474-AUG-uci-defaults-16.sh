	local macaddr="$1"

	json_select_object system
		json_add_string label_macaddr "$macaddr"
	json_select ..
