	__network_ifstatus "$1" "$2" "['dns-server'][*]" && return 0

	[ "$3" = 1 -o "$3" = "true" ] && \
		__network_ifstatus "$1" "$2" ".inactive['dns-server'][*]"
