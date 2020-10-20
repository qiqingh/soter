	if [ "$#" != "9" ]; then
		echo "Mac address must be 6 bytes!"
		exit 1
	fi

	if [ "$1" == "lan" ]; then
		#write lan mac
		Set_offset_data 6 ${lan_mac_offset} $@

	elif [ "$1" == "wan" ]; then
		#write wan mac
		Set_offset_data 6 ${wan_mac_offset} $@
	else
		usage
		exit 1
	fi
