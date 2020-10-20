	PHY_IF=$1
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}
	fi
	if [ "EA9200" != "$MODEL_NAME" ] ; then
		return
	fi
	if [ "`get_syscfg_interface_name $PHY_IF`" = "wl1" ] || [ "`get_syscfg_interface_name $PHY_IF`" = "wl2" ]; then
		wl -i $PHY_IF amsdu 1
		wl -i $PHY_IF ampdu_mpdu 32
		wl -i $PHY_IF nar 0
	fi
