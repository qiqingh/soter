	local basepath="/proc/device-tree"
	local macdevice="$(cat "$basepath/aliases/label-mac-device" 2>/dev/null)"
	local macaddr

	[ -n "$macdevice" ] || return

	macaddr=$(get_mac_binary "$basepath/$macdevice/mac-address" 0 2>/dev/null)
	[ -n "$macaddr" ] || macaddr=$(get_mac_binary "$basepath/$macdevice/local-mac-address" 0 2>/dev/null)

	echo $macaddr
