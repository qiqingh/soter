	local type="$1"; shift

	for name in "$@"; do
		json_add_array ""
		json_add_string "" "$name"
		json_add_int "" "$type"
		json_close_array
	done
