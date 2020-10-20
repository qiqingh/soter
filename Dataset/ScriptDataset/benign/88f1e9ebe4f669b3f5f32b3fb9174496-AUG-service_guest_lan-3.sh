    VENDOR_INDEX=`echo $1 | sed 's/eth//g'`
    SYSCFG_INDEX=`expr $VENDOR_INDEX - 1`
    NEED_MAP=`syscfg get wl_interface_map`
    if [ "0" = "$SYSCFG_INDEX" ]; then
	if [ "1" = "$NEED_MAP" ]; then
		SYSCFG_INDEX="1"
	fi	
    else
	if [ "1" = "$NEED_MAP" ]; then
		SYSCFG_INDEX="0"
	fi
    fi
    return $SYSCFG_INDEX
