	local name="$1"
	local script="$2"

	_PROCD_SERVICE="$name"
	_PROCD_INSTANCE_SEQ=0

	json_init
	json_add_string name "$name"
	[ -n "$script" ] && json_add_string script "$script"
	json_add_object instances
