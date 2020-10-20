	local __addr __addr6

	network_get_ipaddrs __addr "$2"
	network_get_ipaddrs6 __addr6 "$2"

	if [ -n "$__addr" -o -n "$__addr6" ]; then
		export "$1=${__addr:+$__addr }$__addr6"
		return 0
	fi

	unset "$1"
	return 1
