	num_of_wifi=$1
	storage=$2
	DEFAULT_RPS=0

	#Physical IRQ# setting
	eth_trx=10
	PCIe0=11
	PCIe1=31

	# Please update the CPU binding in each cases.
	# CPU#_AFFINITY="add binding irq number here"
	# CPU#_RPS="add binding interface name here"
	dbg "[MT7621]"
	if [ "$num_of_wifi" = "0" ]; then
		CPU0_AFFINITY="$eth_trx"
		CPU1_AFFINITY=""
		CPU2_AFFINITY=""
		CPU3_AFFINITY=""

		CPU0_RPS="$ethif1 $ethif2"
		CPU1_RPS="$ethif1 $ethif2"
		CPU2_RPS="$ethif1 $ethif2"
		CPU3_RPS="$ethif1 $ethif2"
	elif [ "$num_of_wifi" = "1" ]; then
                CPU0_AFFINITY=""
                CPU1_AFFINITY="$eth_trx"
                CPU2_AFFINITY="$PCIe0"
                CPU3_AFFINITY="$PCIe1"

                CPU0_RPS="$ethif1 $ethif2 $wifi1 $wifi2 $wifi1_apcli0"
                CPU1_RPS="$wifi1 $wifi2 $wifi1_apcli0"
                CPU2_RPS="$ethif1 $ethif2"
                CPU3_RPS=""
	elif [ "$num_of_wifi" = "2" ]; then
		CPU0_AFFINITY=""
		CPU1_AFFINITY="$eth_trx"
		CPU2_AFFINITY="$PCIe0"
		CPU3_AFFINITY="$PCIe1"

		CPU0_RPS="$ethif1 $ethif2 $wifi1 $wifi2 $wifi1_apcli0 $wifi2_apcli0"
		CPU1_RPS="$wifi1 $wifi2 $wifi1_apcli0 $wifi2_apcli0"
		CPU2_RPS="$ethif1 $ethif2"
		CPU3_RPS=""
	else
		dbg "MT7621 with $NUM_OF_WIFI Wi-Fi bands is not support"
	fi
