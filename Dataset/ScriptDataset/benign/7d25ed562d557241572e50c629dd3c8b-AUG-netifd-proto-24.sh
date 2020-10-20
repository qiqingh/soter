	local str="$1"
	local address mask broadcast ptp

	address="${str%%/*}"
	str="${str#*/}"
	mask="${str%%/*}"
	str="${str#*/}"
	broadcast="${str%%/*}"
	str="${str#*/}"
	ptp="$str"

	json_add_object ""
	json_add_string ipaddr "$address"
	[ -n "$mask" ] && json_add_string mask "$mask"
	[ -n "$broadcast" ] && json_add_string broadcast "$broadcast"
	[ -n "$ptp" ] && json_add_string ptp "$ptp"
	json_close_object
