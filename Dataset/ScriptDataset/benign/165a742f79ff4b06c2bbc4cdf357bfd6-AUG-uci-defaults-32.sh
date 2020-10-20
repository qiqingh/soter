	local dev="$1"
	local refresh="$2"
	local threshold="$3"

	json_select_object rssimon

	json_select_object "$dev"
	[ -n "$refresh" ] && json_add_int refresh "$refresh"
	[ -n "$threshold" ] && json_add_int threshold "$threshold"
	json_select ..

	json_select ..

