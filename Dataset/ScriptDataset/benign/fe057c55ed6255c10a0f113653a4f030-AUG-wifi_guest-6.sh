	ulog guest status "${SERVICE_NAME}, bringing down guest lan "
	PHY_IF=$1
	INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	GUEST_VAP=`syscfg_get "$INDEX"_guest_vap`
	GUEST_BRIDGE=`syscfg_get guest_lan_ifname`
	delete_guest_vlan_from_backhaul
	delete_interface_from_bridge $GUEST_VAP $GUEST_BRIDGE
	ifconfig $GUEST_VAP down
	ulog guest status "${SERVICE_NAME}, guest $GUEST_VAP is down"
	echo "${SERVICE_NAME}, guest $GUEST_VAP is down " > /dev/console
	return 0
