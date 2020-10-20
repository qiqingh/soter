	local annex="$1"
	local tone="$2"
	local xfer_mode="$3"

	json_select_object dsl
		json_select_object modem
			json_add_string type "vdsl"
			json_add_string annex "$annex"
			json_add_string tone "$tone"
			json_add_string xfer_mode "$xfer_mode"
		json_select ..
	json_select ..
