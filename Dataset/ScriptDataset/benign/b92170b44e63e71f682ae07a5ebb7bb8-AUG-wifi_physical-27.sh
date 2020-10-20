	PHY_IF=$1
	RTS_THRESHOLD=`get_driver_rts_threshold "$PHY_IF"`
	if [ -n $RTS_THRESHOLD ]; then
		echo "wifi, $PHY_IF setting rts thresh"
		set_wifi_val $PHY_IF RTSThreshold $RTS_THRESHOLD
	fi
	return 0
