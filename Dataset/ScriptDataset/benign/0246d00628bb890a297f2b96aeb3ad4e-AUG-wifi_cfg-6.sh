	local wifi_if=$1
	local wifi_param=$2
	local val=$3
	echo -n "$val" > $CACHE_DIR/$wifi_if/$wifi_param
