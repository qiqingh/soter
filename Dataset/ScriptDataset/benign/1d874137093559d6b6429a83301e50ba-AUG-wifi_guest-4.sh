	PHY_IF=$1
	ulog guest status "${SERVICE_NAME}, guest_start($PHY_IF) "
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$SYSCFG_INDEX"_guest_vap`
	GUEST_BRIDGE=`syscfg_get guest_lan_ifname`
	INT=`get_phy_interface_name_from_vap "$PHY_IF"`
	wlanconfig $GUEST_VAP create wlandev $INT wlanmode ap
	/sbin/ifconfig $GUEST_VAP txqueuelen 1000
	add_interface_to_bridge $GUEST_VAP $GUEST_BRIDGE
	set_driver_mac_filter_enabled $GUEST_VAP
	configure_guest $PHY_IF
	add_guest_vlan_to_backhaul
	return 0
