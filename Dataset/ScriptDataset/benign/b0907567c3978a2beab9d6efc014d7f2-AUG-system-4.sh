	local macaddr=$(get_mac_label_dt)

	[ -n "$macaddr" ] || macaddr=$(get_mac_label_json)

	echo $macaddr
