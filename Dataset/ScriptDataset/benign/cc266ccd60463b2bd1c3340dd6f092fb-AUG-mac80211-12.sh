	wpa_supplicant_prepare_interface "$ifname" nl80211 || return 1
	wpa_supplicant_add_network "$ifname"
	wpa_supplicant_run "$ifname" ${hostapd_ctrl:+-H $hostapd_ctrl}
