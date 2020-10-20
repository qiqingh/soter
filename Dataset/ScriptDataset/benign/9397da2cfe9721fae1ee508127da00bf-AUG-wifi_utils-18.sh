	VID=`syscfg_get guest_vlan_id`
	GUEST_BRIDGE=`syscfg_get guest_lan_ifname`
	BACKHAUL_IF_LIST=`syscfg_get backhaul_ifname_list`
	for INTF in $BACKHAUL_IF_LIST; do
		vconfig set_name_type DEV_PLUS_VID_NO_PAD
		vconfig add $INTF $VID
		add_interface_to_bridge $INTF.$VID $GUEST_BRIDGE
		ebtables -t broute -I BROUTING -i $INTF -p 802.1Q --vlan-id $VID -j DROP
	done
	return 0
