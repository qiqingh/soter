    	VENDOR_INDEX=`echo $1 | sed 's/eth//g'`
    	NVRAM_INDEX=`expr $VENDOR_INDEX - 1`
    	echo wl"$NVRAM_INDEX"
