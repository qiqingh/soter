	local dev="$1"
	local refresh="$2"
	local threshold="$3"

	json_select_object led
	
	json_select_object rssi
	json_add_string type rssi
	json_add_string dev $dev
	json_add_string threshold $threshold
	json_select ..

	json_select ..
	
