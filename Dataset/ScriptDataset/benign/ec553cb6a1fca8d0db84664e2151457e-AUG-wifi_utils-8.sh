	VAP=$1
	BRIDGE=$2
	if [ -z "$BRIDGE" ]; then	 
		ulog wlan status "${SERVICE_NAME}, add_interface_to_bridge(), bridge name is empty"
		return 1
	fi
	TEMP=`brctl show | grep ${BRIDGE} | awk '{print $1}'`
	if [ "$BRIDGE" = "$TEMP" ]; then
		MAC_1=`get_mac ${VAP}`
		if [ ! -z "$MAC_1" ]; then	 
			ip link set $VAP allmulticast on
			ip link set $VAP up
			MAC_2=`brctl showmacs ${BRIDGE} | grep ${MAC_1} | awk '{print $2}'`
			if [ "${MAC_1}" = "${MAC_2}" ]; then
				brctl delif $BRIDGE $VAP
			fi
			brctl addif $BRIDGE $VAP
		fi
	fi 
