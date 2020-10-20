	wpa_supplicant_prepare_interface "$ifname" nl80211 || return 1
	if [ "$mode" = "sta" ]; then
		wpa_supplicant_add_network "$ifname"
	else
		wpa_supplicant_add_network "$ifname" "$freq" "$htmode" "$noscan"
	fi
	wpa_supplicant_run "$ifname" ${hostapd_ctrl:+-H $hostapd_ctrl}
