    ORIG_INDEX=$1
    TRANS_INDEX="0"
    NEED_MAP=`syscfg get wl_interface_map`
    if [ "wl0" = "$ORIG_INDEX" ]; then
	if [ "1" = "$NEED_MAP" ]; then
		TRANS_INDEX="1"
	else
		TRANS_INDEX="0"
	fi
    else
	if [ "1" = "$NEED_MAP" ]; then
		TRANS_INDEX="0"
	else
		TRANS_INDEX="1"
	fi
    fi
    return $TRANS_INDEX
