	vlanif="$1"
	vlanid="$2"
	echo "##### config Vlan interface in VLAN mode #####"
	if [ "$CONFIG_TASKLET_WORKQUEUE_SW" == "y" ]; then
		ifconfig eth2 down
		PLATFORM=`nvram_get 2860 Platform | tr A-Z a-z`
		if [ "$wanmode" == "PPPOE" -o "$wanmode" == "L2TP" -o "$wanmode" == "PPTP" ]; then
			echo 1 > /proc/$PLATFORM/schedule
		else
			echo 0 > /proc/$PLATFORM/schedule
		fi
	fi
	ifconfig ${vlanif} 0.0.0.0
	if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
		ifconfig eth3 up
		enableIPv6dad eth3 2

	elif [ "$CONFIG_RAETH_ROUTER" = "y" -o "$CONFIG_MAC_TO_MAC_MODE" = "y" -o "$CONFIG_RT_3052_ESW" = "y" ]; then

		echo "First remmove all vlan interfaces..."
		for vlan in $(cat /proc/net/vlan/config |grep eth2 |cut -d" " -f1);do
			vconfig rem $vlan
		done
		#vconfig rem "${vlanif}.${vlanid}"
		#vconfig rem eth2.1
		#vconfig rem eth2.2
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			vconfig rem eth2.3
			vconfig rem eth2.4
			vconfig rem eth2.5
		fi
		rmmod 8021q
		if [ "$CONFIG_VLAN_8021Q" == "m" ]; then
		insmod -q 8021q
		fi

		vconfig add eth2 1
		set_vlan_map eth2.1
		vconfig add ${vlanif} ${vlanid}
		set_vlan_map "${vlanif}.${vlanid}"

		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			vconfig add eth2 3
			set_vlan_map eth2.3
			vconfig add eth2 4
			set_vlan_map eth2.4
			vconfig add eth2 5
			set_vlan_map eth2.5

			if [ "$CONFIG_WAN_AT_P0" = "y" ]; then
				ifconfig eth2.1 down
				wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
				if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
					ifconfig eth2.1 hw ether $wan_mac
				fi
				enableIPv6dad eth2.1 1
			else
				ifconfig eth2.5 down
				wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
				if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
					ifconfig eth2.5 hw ether $wan_mac
				fi
				enableIPv6dad eth2.5 1
			fi
		else
			ifconfig "${vlanif}.${vlanid}" down
			wan_mac=`nvram_get 2860 WAN_MAC_ADDR`
			if [ "$wan_mac" != "FF:FF:FF:FF:FF:FF" ]; then
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
				ifconfig "${vlanif}.${vlanid}" hw ether $wan_mac
			fi
			enableIPv6dad "${vlanif}.${vlanid}" 1
		fi

		ifconfig eth2.1 0.0.0.0
		ifconfig "${vlanif}.${vlanid}" 0.0.0.0
		ifconfig "${vlanif}.${vlanid}" 0.0.0.0
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
			ifconfig eth2.3 0.0.0.0
			ifconfig eth2.4 0.0.0.0
			ifconfig eth2.5 0.0.0.0
		fi

	elif [ "$CONFIG_ICPLUS_PHY" = "y" ]; then
		#remove ip alias
		# it seems busybox has no command to remove ip alias...
		ifconfig eth2:1 0.0.0.0 1>&2 2>/dev/null
	fi
