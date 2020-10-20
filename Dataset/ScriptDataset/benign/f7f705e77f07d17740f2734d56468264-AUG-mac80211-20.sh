	local service="$1"
	local vaps="$2"

	for wdev in $vaps; do
		[ "$service" != "none" ] && ubus call ${service} config_remove "{\"iface\":\"$wdev\"}"
		ip link set dev "$wdev" down 2>/dev/null
		iw dev "$wdev" del
	done
