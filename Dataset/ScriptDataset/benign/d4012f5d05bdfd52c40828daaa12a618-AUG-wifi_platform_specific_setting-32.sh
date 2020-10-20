	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}
	fi
	nvram_set wl_radio 1
	nvram_set wl0_radio 1
	nvram_set wl1_radio 1
	if [ "EA9200" = "$MODEL_NAME" ] || [ "EA9500" = "$MODEL_NAME" ] || [ "EA9400" = "$MODEL_NAME" ] ; then
		nvram_set wl2_radio 1
	fi
