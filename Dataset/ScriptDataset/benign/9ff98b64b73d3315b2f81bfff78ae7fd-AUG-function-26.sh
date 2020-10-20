	start_wireless
	if [ "$opmode" = "0" ]; then
#addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		addWds2Br0
		addMesh2Br0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
#		wan.sh
#		lan.sh
		if [ "$wireless_bridge" = "1" ]; then
			ifRaxDown
			ifRaixDown
		fi
	elif [ "$opmode" = "1" ]; then
		addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		addWds2Br0
		addMesh2Br0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
#		lan.sh
#		nat.sh

		# set the global ipv6 address for LAN/WAN, enable ipv6 forwarding,
		# enable ecmh(multicast) daemon
	elif [ "$opmode" = "2" ]; then
		addBr0
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
		lan.sh
		nat.sh
	elif [ "$opmode" = "3" ]; then
		addBr0
		if [ "$RadioOff_24" = "0" ]; then
			addRax2Br0
		fi
		brctl addif br0 eth2
		if [ "$CONFIG_GE2_RGMII_AN" = "y" -o "$CONFIG_GE2_INTERNAL_GPHY" = "y" ]; then
			brctl addif br0 eth3
		fi
		if [ "$RadioOff_5" = "0" ]; then
			addRaix2Br0
		fi
		addInicWds2Br0
		addRaL02Br0
		addRaex2Br0
		#wan.sh
		lan.sh
		nat.sh
	else
		echo "unknown OperationMode: $opmode"
		exit 1
	fi
