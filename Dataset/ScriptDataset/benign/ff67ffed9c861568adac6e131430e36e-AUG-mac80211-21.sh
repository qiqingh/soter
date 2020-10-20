	local phy="$1"

	for wdev in $(list_phy_interfaces "$phy"); do
		ip link set dev "$wdev" down 2>/dev/null
		iw dev "$wdev" del
	done
