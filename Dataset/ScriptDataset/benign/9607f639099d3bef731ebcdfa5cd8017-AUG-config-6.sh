	local config="$1"

	[ -n "$config" ] || return 0
	ubus call network.interface."$config" prepare
