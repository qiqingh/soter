	PHY_IF=$1
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}	
	fi
	if [ "EA9200" = "$MODEL_NAME" ] ; then
		EMF_WMF=`syscfg get emf_wmf`
		if [ "disable" != "$EMF_WMF" ]; then
			dhd -i $PHY_IF wmf_bss_enable 1
		else
			dhd -i $PHY_IF wmf_bss_enable 0
		fi
		return
	fi
	EMF_WMF=`syscfg get emf_wmf`
	if [ "disable" != "$EMF_WMF" ]; then
		wl -i $PHY_IF wmf_bss_enable 1
	else
		wl -i $PHY_IF wmf_bss_enable 0
	fi
