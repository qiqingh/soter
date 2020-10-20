	local type="$1"; shift
	local _json_no_warning=1

	json_select "$type"
	[ $? = 0 ] || {
		_procd_set_param "$type" "$@"
		return
	}
	case "$type" in
		env|data|limits)
			_procd_add_table_data "$@"
		;;
		command|netdev|file|respawn|watch)
			_procd_add_array_data "$@"
		;;
		error)
			json_add_string "" "$@"
		;;
	esac
	json_select ..
