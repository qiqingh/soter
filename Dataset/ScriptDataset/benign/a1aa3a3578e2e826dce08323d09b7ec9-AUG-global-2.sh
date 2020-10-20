	wan_mode=`nvram_get 2860 wanConnectionMode`
	if [ "$opmode" = "0" ]; then
		wan_if="br0"
	elif [ "$opmode" = "1" ]; then
		wan_if="eth1"
	elif [ "$opmode" = "2" ]; then
		wan_if="ra0"
	elif [ "$opmode" = "3" ]; then
		wan_if="apcli0"
	fi

	if [ "$wan_mode" = "PPPOE" -o  "$wan_mode" = "L2TP" -o "$wan_mode" = "PPTP"  ]; then
		wan_ppp_if="ppp0"
	else
		wan_ppp_if=$wan_if
	fi
	#John add nvram value: wan_ifname

	vlan_enable=`nvram_get  2860 vlan_enable`
	if [ "${vlan_enable}" == "1" ]; then
        	wan_vid=`nvram_get 2860 vlan_id_0`
		nvram_set 2860 wan_ifname vlan$wan_vid
	else
		nvram_set 2860 wan_ifname $wan_if
	fi
