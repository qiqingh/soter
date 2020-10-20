	local str="$1"
	local address mac proxy

	address="${str%%/*}"
	str="${str#*/}"
	mac="${str%%/*}"
	str="${str#*/}"
	proxy="${str%%/*}"

	json_add_object ""
	json_add_string ipaddr "$address"
	[ -n "$mac" ] && json_add_string mac "$mac"
	[ -n "$proxy" ] && json_add_boolean proxy "$proxy"
	json_close_object
