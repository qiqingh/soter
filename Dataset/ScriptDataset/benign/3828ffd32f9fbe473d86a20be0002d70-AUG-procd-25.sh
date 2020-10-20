    let '_procd_trigger_open = _procd_trigger_open - 1'
    [ "$_procd_trigger_open" -lt 1 ] || return
	json_close_array
