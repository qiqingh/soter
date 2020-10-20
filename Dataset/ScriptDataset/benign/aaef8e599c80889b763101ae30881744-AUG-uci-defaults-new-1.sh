	local _json_no_warning=1

	json_select "$1"
	[ $? = 0 ] && return

	json_add_array $1
	json_close_array

	json_select "$1"
