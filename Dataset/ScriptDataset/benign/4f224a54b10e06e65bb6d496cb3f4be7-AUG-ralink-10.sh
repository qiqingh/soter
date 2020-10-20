	json_select config
	json_get_vars ifname
	json_select ..

	local ifname="$base_ifname$ap_idx"
	ap_idx=$(($ap_idx + 1))

	ifconfig $ifname down
