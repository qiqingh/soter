    RET_VAL="0"
    MODEL=`syscfg get device::model_base`
    if [ -z "$MODEL" ] ; then
        MODEL=`syscfg get device::modelNumber`
    fi
    if [ "$MODEL" = "EA6200" -o "$MODEL" = "EA6300" -o "$MODEL" = "EA6350" -o "$MODEL" = "EA6400" -o "$MODEL" = "EA6500" -o "$MODEL" = "EA6700" -o "$MODEL" = "EA6900" ] ; then
        HW_REVISION=`syscfg get device::hw_revision`
    	if [ "$MODEL" = "EA6500" -a "$HW_REVISION" = "1" ]; then
    		RET_VAL="0"
    	else
			RET_VAL="1"
    	fi
    fi
    return $RET_VAL
