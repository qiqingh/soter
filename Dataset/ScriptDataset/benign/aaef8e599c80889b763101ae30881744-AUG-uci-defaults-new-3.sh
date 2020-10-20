	local name=$1
	local iface=$2

	json_select_object $name
	json_add_string ifname "${iface%%.*}"
	[ "$iface" = "${iface%%.*}" ] || json_add_boolean create_vlan 1
	json_select ..
