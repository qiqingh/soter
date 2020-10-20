	local config="$1"
	local ifname type device l3dev

	config_get type "$config" type
	config_get ifname "$config" ifname
	config_get device "$config" device "$ifname"
	[ "bridge" = "$type" ] && ifname="br-$config"
	config_set "$config" device "$ifname"
	ubus_call "network.interface.$config" status || return 0
	json_get_var l3dev l3_device
	[ -n "$l3dev" ] && ifname="$l3dev"
	json_init
	config_set "$config" ifname "$ifname"
	config_set "$config" device "$device"
