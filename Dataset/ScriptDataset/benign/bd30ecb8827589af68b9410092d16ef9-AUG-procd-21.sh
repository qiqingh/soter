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
		nice|term_timeout)
			json_add_int "$type" "$1"
		;;
		reload_signal)
			json_add_int "$type" $(kill -l "$1")
		;;
		pidfile|user|group|seccomp|capabilities|facility|\
		extroot|overlaydir|tmpoverlaysize)
			json_add_string "$type" "$1"
		;;
		stdout|stderr|no_new_privs)
			json_add_boolean "$type" "$1"
		;;
	esac
