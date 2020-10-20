    RET_VAL="1"
    MODEL=`syscfg get device::model_base`
    if [ -z "$MODEL" ] ; then
        MODEL=`syscfg get device::modelNumber`
    fi
    HW_REVISION=`syscfg get device::hw_revision`
    if [ "$MODEL" = "EA2700" ] || [ "$MODEL" = "EA6500" -a "$HW_REVISION" = "1" ] ; then
    	RET_VAL="0"
    fi
    return $RET_VAL
