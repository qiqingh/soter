	sleep_time=$1

	#if [ "$CONFIG_RAETH_ROUTER" != "y" -a "$CONFIG_RT_3052_ESW" != "y" ]; then
	#	return
	#fi

	opmode=`nvram_get 2860 OperationMode`

	#skip WAN port
	if [ "$opmode" != "1" ]; then #no wan port
		link_down 0
		link_down 4
	elif [ "$CONFIG_WAN_AT_P4" = "y" ]; then #wan port at port4
		link_down 0
	elif [ "$CONFIG_WAN_AT_P0" = "y" ]; then #wan port at port0
		link_down 4
	fi
	link_down 1
	link_down 2
	link_down 3

	#force Windows clients to renew IP and update DNS server
	sleep $sleep_time

	#skip WAN port
	if [ "$opmode" != "1" ]; then #no wan port
		link_up 0
		link_up 4
	elif  [ "$CONFIG_WAN_AT_P4" = "y" ]; then #wan port at port4
		link_up 0
	elif [ "$CONFIG_WAN_AT_P0" = "y" ]; then #wan port at port0
		link_up 4
	fi
	link_up 1
	link_up 2
	link_up 3
