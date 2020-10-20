	PHY_IF=$1
	INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$INDEX"_guest_vap`
	GUEST_BRIDGE=`syscfg_get guest_lan_ifname`
	LAN_MAC=`ip link show $SYSCFG_lan_ifname | grep link | awk '{print $2}'`
	GUEST_LAN_MAC=`ip link show $GUEST_BRIDGE | grep link | awk '{print $2}'`
	if [ "$LAN_MAC" = "$GUEST_LAN_MAC" ]; then
		REPLACEMENT=`incr_mac $GUEST_LAN_MAC 1`
		ip link set $GUEST_BRIDGE down 
		ip link set $GUEST_BRIDGE addr $REPLACEMENT
		ip link set $GUEST_BRIDGE up 
		ulog guest status "${SERVICE_NAME}, mac address changed from $GUEST_LAN_MAC to $REPLACEMENT"
	fi
	set_driver_mac_filter_enabled $GUEST_VAP 1
	add_guest_vlan_to_backhaul
	return 0
