	PHY_IF=$1
	WLINDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	FRAG=`syscfg_get "$WLINDEX"_fragmentation_threshold`
	if [ -n $FRAG ]; then
		echo "wifi, $PHY_IF setting framentation thresh"
	set_wifi_val $PHY_IF FragThreshold $FRAG
	fi
	return 0
