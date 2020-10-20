	local cfg="$1"
	local proto
	config_get proto "$cfg" proto
	[ "$proto" = wwan ] || return 0
	proto_set_available "$cfg" 1
	ifup $cfg
	exit 0
