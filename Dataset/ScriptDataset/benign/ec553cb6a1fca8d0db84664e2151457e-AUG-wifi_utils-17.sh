	RATE=-1
	if [ -n "$1" ]; then
		if [ "auto" = "$1" ]; then
			RATE=-1
		elif [ $1 -ge 0 ] && [ $1 -le 15 ]; then
			RATE=$1
		else
			ulog wlan status "invalid n_transmission_rate: $1"
		fi
	fi
	echo "$RATE"
