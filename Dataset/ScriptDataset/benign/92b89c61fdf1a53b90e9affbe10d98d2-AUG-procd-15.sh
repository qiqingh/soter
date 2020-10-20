	let '_procd_data_open = _procd_data_open - 1'
	[ "$_procd_data_open" -lt 1 ] || return
	json_close_object
