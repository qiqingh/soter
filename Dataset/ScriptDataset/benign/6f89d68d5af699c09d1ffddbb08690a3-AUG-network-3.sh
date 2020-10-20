	__network_ifstatus "$1" "$2" "['ipv6-address'][0].address" || \
		__network_ifstatus "$1" "$2" "['ipv6-prefix-assignment'][0]['local-address'].address" || \
		return 1
