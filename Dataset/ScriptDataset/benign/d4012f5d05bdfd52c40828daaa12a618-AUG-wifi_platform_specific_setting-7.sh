	IFNAME=$1
	CHAN_TABLE=`wl -i ${IFNAME} chan_info`
	echo "$CHAN_TABLE"
