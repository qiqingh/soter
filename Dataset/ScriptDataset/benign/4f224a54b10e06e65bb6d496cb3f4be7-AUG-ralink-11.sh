	local ifname="$1"
	wireless_process_kill_all

	ap_idx=0
	base_ifname="${ifname%0}"
	sta_ifname="apcli${ifname#ra}"

	for_each_interface "ap" ralink_teardown_ap
	ifconfig "$sta_ifname" down
