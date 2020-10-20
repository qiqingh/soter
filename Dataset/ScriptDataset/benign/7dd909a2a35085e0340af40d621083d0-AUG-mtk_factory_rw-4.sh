	if [ "$1" == "lan" ]; then
		#read lan mac
		Get_offset_data 6 ${lan_mac_offset}
	elif [ "$1" == "wan" ]; then
		#read wan mac
		Get_offset_data 6 ${wan_mac_offset}
	else
		usage
		exit 1
	fi
