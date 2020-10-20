	local _v_dest="$1"
	local _v_keys _v_val _select=
	local _json_no_warning=1

	unset "$_v_dest"
	[ -n "$2" ] && {
		json_select "$2" || return 1
		_select=1
	}

	json_get_keys _v_keys
	set -- $_v_keys
	while [ "$#" -gt 0 ]; do
		json_get_var _v_val "$1"
		__jshn_raw_append "$_v_dest" "$_v_val"
		shift
	done
	[ -n "$_select" ] && json_select ..

	return 0
