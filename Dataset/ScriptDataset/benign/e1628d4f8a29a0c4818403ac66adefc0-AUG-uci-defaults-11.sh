	local name="$1"
	local type="$2"
	local interval="$3"

	json_select_object switch
		json_select_object "$name"
			json_add_int ar8xxx_mib_type $type
			json_add_int ar8xxx_mib_poll_interval $interval
		json_select ..
	json_select ..
