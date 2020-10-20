	brctl addbr br0

	# configure stp forward delay
	if [ "$wan_if" = "br0" -o "$lan_if" = "br0" ]; then
		stp=`nvram_get 2860 stpEnabled`
		if [ "$stp" = "1" ]; then
			brctl setfd br0 15
			brctl stp br0 1
		else
			brctl setfd br0 1
			brctl stp br0 0
		fi
		enableIPv6dad br0 2
	fi

