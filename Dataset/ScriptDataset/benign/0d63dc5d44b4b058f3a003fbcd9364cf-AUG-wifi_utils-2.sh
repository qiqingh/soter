	TRANS_INDEX=$1
	NEED_MAP=`syscfg get eth1_syscfg_index`
	if [ "wl0" = "$TRANS_INDEX" ] && [ "wl1" = "$NEED_MAP" ]; then
		TRANS_INDEX="wl1"
	elif [ "wl1" = "$TRANS_INDEX" ] && [ "wl1" = "$NEED_MAP" ]; then
		TRANS_INDEX="wl0"
	fi
	echo "$TRANS_INDEX"
