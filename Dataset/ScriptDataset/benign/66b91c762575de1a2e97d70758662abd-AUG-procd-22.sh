	json_add_array
	_procd_add_array_data "$1"
	shift

	json_add_array
	_procd_add_array_data "if"

	json_add_array
	_procd_add_array_data "eq" "package" "$1"
	shift
	json_close_array

	json_add_array
	_procd_add_array_data "run_script" "$@"
	json_close_array

	json_close_array

	json_close_array

	_procd_add_timeout
