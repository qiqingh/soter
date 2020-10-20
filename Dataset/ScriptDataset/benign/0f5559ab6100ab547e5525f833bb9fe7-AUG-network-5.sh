	local __nets __addr

	if network_get_subnets6 __nets "$2"; then
		# Attempt to return first non-fe80::/10, non-fc::/7 range
		for __addr in $__nets; do
			case "$__addr" in fe[8ab]?:*|f[cd]??:*)
				continue
			esac
			export "$1=$__addr"
			return 0
		done

		# Attempt to return first non-fe80::/10 range
		for __addr in $__nets; do
			case "$__addr" in fe[8ab]?:*)
				continue
			esac
			export "$1=$__addr"
			return 0
		done

		# Return first item
		for __addr in $__nets; do
			export "$1=$__addr"
			return 0
		done
	fi

	unset "$1"
	return 1
