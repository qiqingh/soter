	wpa_supplicant_prepare_interface "$ifname" nl80211 || return 1
	wpa_supplicant_add_network "$ifname" "$freq" "$htmode" "$noscan"
	wpa_supplicant_run "$ifname"
