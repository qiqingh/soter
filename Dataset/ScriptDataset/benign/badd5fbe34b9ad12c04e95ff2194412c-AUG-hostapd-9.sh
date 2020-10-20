	local ifname="$1"
	local vlan="$2"
	json_get_vars name vid
	echo "${vid} ${ifname}-${name}" >> /var/run/hostapd-${ifname}.vlan
	wireless_add_vlan "${vlan}" "${ifname}-${name}"
