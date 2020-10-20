	local vpi="$1"
	local vci="$2"
	local encaps="$3"
	local payload="$4"

	json_select_object dsl
		json_select_object atmbridge
			json_add_int vpi "$vpi"
			json_add_int vci "$vci"
			json_add_string encaps "$encaps"
			json_add_string payload "$payload"
		json_select ..
	json_select ..
