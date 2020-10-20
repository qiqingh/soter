	DTIM=1
	if [ -n "$1" ] && [ $1 -ge 1 ] && [ $1 -le 255 ]; then
		DTIM=$1
	fi
	echo "$DTIM"
