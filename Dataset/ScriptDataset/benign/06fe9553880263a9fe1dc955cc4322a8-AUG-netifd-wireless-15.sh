	_wdev_notify_init $CMD_PROCESS_ADD
	local exe="$2"
	[ -L "$exe" ] && exe="$(readlink -f "$exe")"
	json_add_int pid "$1"
	json_add_string exe "$exe"
	[ -n "$3" ] && json_add_boolean required 1
	exe2="$(readlink -f /proc/$pid/exe)"
	[ "$exe" = "$exe2" ] && echo "WARNING (wireless_add_process): executable path $exe does not match process $1 path ($exe2)"
	_wdev_notify
