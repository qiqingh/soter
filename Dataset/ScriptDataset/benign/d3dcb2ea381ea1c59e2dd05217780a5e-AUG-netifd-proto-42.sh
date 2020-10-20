	local interface="$1"
	local host="$2"
	local ifname="$3"

	# execute in subshell to not taint callers env
	# see tickets #11046, #11545, #11570
	(
		json_init
		json_add_int action 6
		json_add_string host "$host"
		[ -n "$ifname" ] && json_add_string ifname "$ifname"
		_proto_notify "$interface" -S
	)
