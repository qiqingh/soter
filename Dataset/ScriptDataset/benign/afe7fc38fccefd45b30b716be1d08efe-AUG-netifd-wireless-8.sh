	while [ -n "$1" ]; do
		eval "$1() { _wdev_msg_call _$1 \"\$@\"; }"
		shift
	done
