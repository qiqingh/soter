    ETH_INDEX=`echo $1 | cut -c4`
    WL_INDEX=`expr $ETH_INDEX - 1`
    NEED_MAP=`syscfg get wl_interface_map`
    if [ "0" = "$WL_INDEX" ]; then
	if [ "1" = "$NEED_MAP" ]; then
	    WL_INDEX="1"
	fi	
    else
        if [ "1" = "$NEED_MAP" ]; then
	    WL_INDEX="0"
	fi
   fi
   return $WL_INDEX
