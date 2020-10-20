	local _new="$1"
	local _old="$2"

	[ -n "$_old" ] && _set_var "$_old" "$JSON_PREFIX"
	JSON_PREFIX="$_new"
