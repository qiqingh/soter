	json_add_array "$1"
	shift
	_procd_add_array_data "$@"
	json_close_array
