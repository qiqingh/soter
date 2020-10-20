	local name="$1"; shift

	_PROCD_INSTANCE_SEQ="$(($_PROCD_INSTANCE_SEQ + 1))"
	name="${name:-instance$_PROCD_INSTANCE_SEQ}"
	json_add_object "$name"
	[ -n "$TRACE_SYSCALLS" ] && json_add_boolean trace "1"
