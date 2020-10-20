	procd_lock
	while [ -n "$1" ]; do
		eval "$1() { _procd_call _$1 \"\$@\"; }"
		shift
	done
