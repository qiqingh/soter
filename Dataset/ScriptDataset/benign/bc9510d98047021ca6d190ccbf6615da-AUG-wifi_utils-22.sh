	TX_POWER=100
	if [ -n "$1" ]; then
		if [ "high" = "$1" ]; then
			TX_POWER=100
		elif [ "medium" = "$1" ]; then
			TX_POWER=60
		elif [ "low" = "$1" ]; then
			TX_POWER=30
		else
			DEBUG echo "invalid n_transmission_power: $1"
		fi
	fi
	echo "$TX_POWER"
