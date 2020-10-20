	local name="$1"; shift
	local ifname="$1"; shift

	_wdev_notify_init $CMD_SET_DATA "vlan" "$name"
	json_add_string "ifname" "$ifname"
	_wdev_add_variables "$@"
	_wdev_notify
