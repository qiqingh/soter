	local _json_no_warning=1

	json_select "$1"
	[ $? = 0 ] && return

	json_add_object $1
	json_close_object

	json_select "$1"
