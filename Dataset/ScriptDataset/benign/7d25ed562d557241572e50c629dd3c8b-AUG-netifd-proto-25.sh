	local str="$1"
	local address mask preferred valid offlink

	address="${str%%/*}"
	str="${str#*/}"
	mask="${str%%/*}"
	str="${str#*/}"
	preferred="${str%%/*}"
	str="${str#*/}"
	valid="${str%%/*}"
	str="${str#*/}"
	offlink="${str%%/*}"
	str="${str#*/}"
	class="${str%%/*}"

	json_add_object ""
	json_add_string ipaddr "$address"
	[ -n "$mask" ] && json_add_string mask "$mask"
	[ -n "$preferred" ] && json_add_int preferred "$preferred"
	[ -n "$valid" ] && json_add_int valid "$valid"
	[ -n "$offlink" ] && json_add_boolean offlink "$offlink"
	[ -n "$class" ] && json_add_string class "$class"
	json_close_object
