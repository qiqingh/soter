	local __addr
	local __list=""

	if __network_ifstatus "__addr" "$2" "['ipv6-address'][*].address"; then
		for __addr in $__addr; do
			__list="${__list:+$__list }${__addr}"
		done
	fi

	if __network_ifstatus "__addr" "$2" "['ipv6-prefix-assignment'][*]['local-address'].address"; then
		for __addr in $__addr; do
			__list="${__list:+$__list }${__addr}"
		done
	fi

	if [ -n "$__list" ]; then
		export "$1=$__list"
		return 0
	fi

	unset "$1"
	return 1