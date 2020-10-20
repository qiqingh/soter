	PHY_IF=$1
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}	
	fi
	if [ "1" = "`syscfg get wl0_256qam_enabled`" ] ; then
		echo "${SERVICE_NAME}, set VHT mode on 2.4 g radio"
		wl -i $PHY_IF ampdu_mpdu 64
		wl -i $PHY_IF mpc 1
		if [ "EA9200" != "$MODEL_NAME" ] && [ "EA9500" != "$MODEL_NAME" ] && [ "EA9400" != "$MODEL_NAME" ] ; then
			wl -i $PHY_IF ack_ratio 4
		fi
	else
		wl -i $PHY_IF ampdu_mpdu -1
		wl -i $PHY_IF mpc 0
		if [ "EA9200" != "$MODEL_NAME" ] && [ "EA9500" != "$MODEL_NAME" ] && [ "EA9400" != "$MODEL_NAME" ] ; then
			wl -i $PHY_IF ack_ratio 2
		fi
	fi
