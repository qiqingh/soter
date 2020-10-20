	wireless_process_kill_all

	json_select data
	json_get_vars phy
	json_select ..

	mac80211_interface_cleanup "$phy"
