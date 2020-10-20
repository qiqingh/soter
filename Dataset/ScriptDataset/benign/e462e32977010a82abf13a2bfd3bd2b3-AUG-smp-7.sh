	NUM_OF_WIFI=0
	if [ -n $wifi1 -a -d "/sys/class/net/$wifi1" ]; then
		NUM_OF_WIFI=`expr $NUM_OF_WIFI + 1`
	fi

	if [ -n $wifi2 -a -d "/sys/class/net/$wifi2" ];then
		NUM_OF_WIFI=`expr $NUM_OF_WIFI + 1`
	fi

	if [ -n $wifi3 -a -d "/sys/class/net/$wifi3" ];then
		NUM_OF_WIFI=`expr $NUM_OF_WIFI + 1`
	fi

	dbg "# NUM_OF_WIFI=$NUM_OF_WIFI band(s)"
