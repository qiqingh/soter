	local enable=$1
	local add_sp=0
	local spobj="$(ubus -S list | grep wpa_supplicant.${ifname})"

	wpa_supplicant_prepare_interface "$ifname" nl80211 || return 1
	wpa_supplicant_prepare_interface "$ifname" nl80211 || {
		iw dev "$ifname" del
		return 1
	}
	if [ "$mode" = "sta" ]; then
		wpa_supplicant_add_network "$ifname"
	else
		wpa_supplicant_add_network "$ifname" "$freq" "$htmode" "$noscan"
	fi

	NEWSPLIST="${NEWSPLIST}$ifname "

	if [ "${NEWAPLIST%% *}" != "${OLDAPLIST%% *}" ]; then
		[ "$spobj" ] && ubus call wpa_supplicant.${phy} config_del "{\"iface\":\"$ifname\"}"
		add_sp=1
	fi
	[ "$enable" = 0 ] && {
		ubus call wpa_supplicant.${phy} config_del "{\"iface\":\"$ifname\"}"
		ip link set dev "$ifname" down
		return 0
	}
	[ -z "$spobj" ] && add_sp=1

	if [ "$add_sp" = "1" ]; then
		wpa_supplicant_run "$ifname" "$hostapd_ctrl"
	else
		ubus call $spobj reload
	fi
