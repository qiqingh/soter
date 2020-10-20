	local _w_vlans _w_vlan

	json_get_keys _w_vlans vlans
	json_select vlans
	for _w_vlan in $_w_vlans; do
		json_select "$_w_vlan"
		json_select config
		"$@" "$_w_vlan"
		json_select ..
		json_select ..
	done
	json_select ..
