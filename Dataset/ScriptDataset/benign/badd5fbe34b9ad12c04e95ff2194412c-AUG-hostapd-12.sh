	local ifname="$1"

	rm -f /var/run/hostapd-${ifname}.psk
	for_each_station hostapd_set_psk_file ${ifname}
