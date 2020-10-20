	wireless_process_kill_all

	for phy in $(ls /sys/class/ieee80211/); do
		mac80211_interface_cleanup "$phy"
		uci -q -P /var/state revert wireless._${phy}
	done
