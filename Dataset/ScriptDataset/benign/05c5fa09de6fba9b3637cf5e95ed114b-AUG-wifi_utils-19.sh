	RTS=2347
	if [ -n "$1" ] && [ $1 -ge 0 ] && [ $1 -le 2347 ]; then
		RTS=$1
	fi
	echo "$RTS"
