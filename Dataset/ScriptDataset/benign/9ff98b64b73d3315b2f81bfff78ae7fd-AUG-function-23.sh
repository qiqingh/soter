	echo "##### configIF #####"

	if [ "$CONFIG_TASKLET_WORKQUEUE_SW" == "y" ]; then
		ifconfig eth2 down
		PLATFORM=`nvram_get 2860 Platform | tr A-Z a-z`
		if [ "$wanmode" == "PPPOE" -o "$wanmode" == "L2TP" -o "$wanmode" == "PPTP" ]; then
			echo 1 > /proc/$PLATFORM/schedule
		else
			echo 0 > /proc/$PLATFORM/schedule
		fi
	fi

	#set_vlan_map eth0
	#set_vlan_map eth1

	ifconfig eth0 0.0.0.0 down
	lan_mac=`nvram_get 2860 lan_hwaddr`
	if [ "$lan_mac" != "FF:FF:FF:FF:FF:FF" \
		-a "$lan_mac" != "0:0:0:0:0:0" \
		-a "$lan_mac" != "00:00:00:00:00:00" \
		-a "$lan_mac" != "" ]; then
		ifconfig eth0 hw ether $lan_mac 0.0.0.0
	else
		ifconfig eth0 0.0.0.0
	fi
	ifconfig eth1 0.0.0.0 down
	wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
	if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" \
		-a "$wan_mac" != "0:0:0:0:0:0" \
		-a "$wan_mac" != "00:00:00:00:00:00" \
		-a "$wan_mac" != "" ]; then
		ifconfig eth1 hw ether $wan_mac
		ifconfig eth1 hw ether $wan_mac
		ifconfig eth1 hw ether $wan_mac
	fi
	enableIPv6dad eth0 1
	enableIPv6dad eth1 1
