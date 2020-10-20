	local __up
	__network_ifstatus "__up" "$1" ".up" && [ "$__up" = 1 ]
