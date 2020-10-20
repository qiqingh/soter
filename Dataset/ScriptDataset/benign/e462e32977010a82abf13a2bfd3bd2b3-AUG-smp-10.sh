	num_of_wifi=$(get_wifi_num)

	if [ "$NUM_OF_CPU" = "4" ]; then
		dbg "setup_model:MT7621 wifi#=$num_of_wifi"
		MT7621 $num_of_wifi
	fi
