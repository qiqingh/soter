	#prepare_ifname
	if [ $active_cards == "2" ]
	then
		radio_band="24G;5G;5G"
	elif [ $active_cards == "3" ]
	then
		radio_band="24G;5GH;5GL"
	fi
	lan_iface=`uci get network.lan.ifname`
	wan_iface=`uci get network.wan.ifname`
#derive almac from br mac
	br0_mac=$(cat /sys/class/net/br-lan/address)
	ctrlr_al_mac=$br0_mac
	agent_al_mac=$br0_mac
