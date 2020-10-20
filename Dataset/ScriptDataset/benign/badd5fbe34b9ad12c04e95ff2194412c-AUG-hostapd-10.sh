	local ifname="$1"

	rm -f /var/run/hostapd-${ifname}.vlan
	for_each_vlan hostapd_set_vlan_file ${ifname}
