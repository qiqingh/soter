	_wdev_notify_init $CMD_PROCESS_KILL_ALL
	[ -n "$1" ] && json_add_int signal "$1"
	_wdev_notify
