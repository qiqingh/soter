	local type

	json_get_type type "$1"
	[ "$type" = "$2" ]
