	VID=`syscfg_get guest_vlan_id`
	BACKHAUL_IF_LIST=`syscfg_get backhaul_ifname_list`
	for INTF in $BACKHAUL_IF_LIST; do
		vconfig rem $INTF.$VID
		ebtables -t broute -D BROUTING -i $INTF -p 802.1Q --vlan-id $VID -j DROP
	done
	return 0
