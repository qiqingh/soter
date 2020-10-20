	local enable=$1
	local spobj="$(ubus -S list | grep wpa_supplicant.${ifname})"
	wpa_supplicant_prepare_interface "$ifname" nl80211 || {
		iw dev "$ifname" del
		return 1
	}

	wpa_supplicant_add_network "$ifname" "$freq" "$htmode" "$noscan"

	NEWSPLIST="${NEWSPLIST}$ifname "
	[ "$enable" = 0 ] && {
		ubus call wpa_supplicant.${phy} config_del "{\"iface\":\"$ifname\"}"
		ip link set dev "$ifname" down
		return 0
	}
	if [ -z "$spobj" ]; then
		wpa_supplicant_run "$ifname"
	else
		ubus call $spobj reload
	fi
