	local trigger_name="$4"
	local delayon="$5"
	local delayoff="$6"

	_ucidef_set_led_common "$1" "$2" "$3"

	json_add_string trigger "$trigger_name"
	json_add_int delayon "$delayon"
	json_add_int delayoff "$delayoff"
	json_select ..

	json_select ..
