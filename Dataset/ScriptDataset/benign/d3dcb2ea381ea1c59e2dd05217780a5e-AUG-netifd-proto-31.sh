	local str="$1"
	local address mac proxy router

	address="${str%%/*}"
	str="${str#*/}"
	mac="${str%%/*}"
	str="${str#*/}"
	proxy="${str%%/*}"
	str="${str#*/}"
	router="${str%%/*}"

	json_add_object ""
	json_add_string ipaddr "$address"
	[ -n "$mac" ] && json_add_string mac "$mac"
	[ -n "$proxy" ] && json_add_boolean proxy "$proxy"
	[ -n "$router" ] && json_add_boolean router "$router"
	json_close_object
