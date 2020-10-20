	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "$WL_SYSCFG" = "wl0" ] && [ "`syscfg get wl0_chip`" = "11ac" ]; then
		VHT_MODE=`wl -i $PHY_IF vhtmode`
		N_MODE=`wl -i $PHY_IF nmode`
		if [ "1" = "`syscfg get wl0_256qam_enabled`" ] ; then
			wl -i $PHY_IF vht_features 1
		else
			wl -i $PHY_IF vht_features 0
		fi
		wl -i $PHY_IF vhtmode $VHT_MODE
		wl -i $PHY_IF nmode $N_MODE
	fi
	if [ "`cat /etc/product`" = "panamera" ] ; then
		if [ "$WL_SYSCFG" = "wl0" ] ; then
			if [ "1" = "`syscfg get wl0_256qam_enabled`" ] ; then
				wl -i $PHY_IF vht_features 7
			else
				wl -i $PHY_IF vht_features 0
			fi
		else
			wl -i $PHY_IF vht_features 6			
		fi
	fi
