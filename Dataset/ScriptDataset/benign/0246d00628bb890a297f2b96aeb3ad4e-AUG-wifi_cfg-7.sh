	local wifi_band=$1
	local wifi_param=$2
	local if_only=$3
	local def_val2=$4
	local def_val5=$5
	local wifi_if1=ra0
	local wifi_if2=ra1
	local def_val=$def_val2
	if [ -z "$def_val5" ]; then
		def_val5=$def_val2
	fi
	
	if [ "5" = "$wifi_band" ]; then
		wifi_if1=rai0
		wifi_if2=rai1
		def_val=$def_val5
	fi
	val1=`cat $CACHE_DIR/$wifi_if1/$wifi_param 2>/dev/null`
	val2=`cat $CACHE_DIR/$wifi_if2/$wifi_param 2>/dev/null`
	if [ -z "$val1" ]; then
		val1=$def_val
	fi
	if [ -z "$val2" ]; then
		val2=$def_val
	fi
	if [ "1" = "$if_only" ]; then
		echo "$val1"
	elif [ "2" = "$if_only" ]; then
		echo "$val2"
	else
		echo "$val1;$val2"
	fi
