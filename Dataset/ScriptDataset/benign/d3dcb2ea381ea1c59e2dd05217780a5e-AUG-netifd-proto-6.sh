	[ -n "$defaultroute" ] && json_add_boolean defaultroute "$defaultroute"
	[ -n "$peerdns" ] && json_add_boolean peerdns "$peerdns"
	[ -n "$metric" ] && json_add_int metric "$metric"
