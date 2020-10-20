	let '_procd_trigger_open = _procd_trigger_open + 1'
	[ "$_procd_trigger_open" -gt 1 ] && return
	json_add_array "triggers"
