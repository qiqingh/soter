	local val
	local ret="0x$1"
	local retlen=${#1}

	shift
	while [ -n "$1" ]; do
		val="0x$1"
		ret=$((ret ^ val))
		shift
	done

	printf "%0${retlen}x" "$ret"
