	local type="$1"; shift

	case "$type" in
		env|data|limits)
			_procd_add_table "$type" "$@"
		;;
		command|netdev|file|respawn|watch)
			_procd_add_array "$type" "$@"
		;;
		error)
			json_add_array "$type"
			json_add_string "" "$@"
			json_close_array
		;;
		nice)
			json_add_int "$type" "$1"
		;;
		user|seccomp)
			json_add_string "$type" "$1"
		;;
		stdout|stderr)
			json_add_boolean "$type" "$1"
		;;
	esac
