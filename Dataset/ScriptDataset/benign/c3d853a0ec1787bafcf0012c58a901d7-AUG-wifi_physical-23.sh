	PHY_IF=$1
	RTS_THRESHOLD=`get_driver_rts_threshold "$PHY_IF"`
	iwconfig $PHY_IF rts $RTS_THRESHOLD
	return 0
