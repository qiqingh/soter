	VID=$SYSCFG_guest_vlan_id
	for intf in $SYSCFG_backhaul_ifname_list; do
		vconfig rem $intf.$VID
		ebtables -t broute -D BROUTING -i $intf -p 802.1Q --vlan-id $VID -j DROP
	done
