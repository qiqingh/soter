	json_add_object "$1"
	shift
	_procd_add_table_data "$@"
	json_close_object
