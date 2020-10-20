	PHY_IF=$1
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
	fi
	if [ "`get_syscfg_interface_name $PHY_IF`" = "wl0" ] && [ "$MODEL_NAME" = "EA6900" ]; then
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
