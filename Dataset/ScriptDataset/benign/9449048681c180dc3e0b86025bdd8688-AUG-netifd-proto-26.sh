	local name="$1"
	local val="$2"
	local cb="$3"

	[ -n "$val" ] || return 0
	json_add_array "$name"
	for item in $val; do
		eval "$cb \"\$item\""
	done
	json_close_array
