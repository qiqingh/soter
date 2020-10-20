	VID=$SYSCFG_guest_vlan_id
	for intf in $SYSCFG_backhaul_ifname_list; do
		vconfig set_name_type DEV_PLUS_VID_NO_PAD
		vconfig add $intf $VID
		add_interface_to_bridge $intf.$VID $SYSCFG_guest_lan_ifname
		ebtables -t broute -I BROUTING -i $intf -p 802.1Q --vlan-id $VID -j DROP
	done
