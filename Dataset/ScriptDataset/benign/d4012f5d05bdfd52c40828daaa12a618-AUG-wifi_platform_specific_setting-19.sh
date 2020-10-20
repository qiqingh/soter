	PHY_IF=$1
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}	
	fi
	EMF_WMF=`syscfg get emf_wmf`
	if [ "EA9200" = "$MODEL_NAME" ] || [ "EA9500" = "$MODEL_NAME" ] || [ "EA9400" = "$MODEL_NAME" ] ; then
		if [ "disable" != "$EMF_WMF" ]; then
			dhd -i $PHY_IF wmf_bss_enable 1
			dhd -i $PHY_IF wmf_mcast_data_sendup 1
		else
			dhd -i $PHY_IF wmf_bss_enable 0
			dhd -i $PHY_IF wmf_mcast_data_sendup 0
		fi
		return
	else
		if [ "disable" != "$EMF_WMF" ]; then
			wl -i $PHY_IF wmf_bss_enable 1
			wl -i $PHY_IF wmf_mcast_data_sendup 1
		else
			wl -i $PHY_IF wmf_bss_enable 0
			wl -i $PHY_IF wmf_mcast_data_sendup 0
		fi
	fi
