	local retry=0
	while [ $retry -lt 30 ] ; do
		laststatus=`sysevent get eth-status`
		if [ "$laststatus" != "power-cycled" ] ; then
			sleep 1
			retry=`expr $retry + 1`
			echo "wait_eth_power_cycle: $retry" > /dev/console
		else
			return
		fi
	done
