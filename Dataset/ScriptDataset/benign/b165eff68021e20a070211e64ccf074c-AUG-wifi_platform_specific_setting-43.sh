	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "wl0" = "$WL_SYSCFG" ]; then
		myrate=`wl -i $PHY_IF bg_rate`	
	elif [ "wl1" = "$WL_SYSCFG" ] || [ "wl2" = "$WL_SYSCFG" ] ; then
		myrate=`wl -i $PHY_IF a_rate`	
	fi
	if [ "$myrate" = "auto" ]; then
		rate="auto"
	else
		rate=`echo $myrate | grep Mbps | awk '/ / {print $PHY_IF}'`
		if [ -z $rate ]; then 
			rate=`echo $myrate | grep Kbps | awk '/ / {print $PHY_IF}'`
			if [ -z $rate ]; then 
				"Error missing rate information: $myrate" > /dev/console
			else
				rate=`expr $rate / 1000`
			fi
		fi
		rate=`expr $rate \* 1000000`
	fi
	sysevent set "$WL_SYSCFG"_transmission_rate $rate
