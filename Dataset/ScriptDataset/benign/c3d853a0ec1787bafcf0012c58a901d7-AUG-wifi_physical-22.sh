	PHY_IF=$1
	BCNINTERVAL=`get_driver_beacon_interval "$PHY_IF"`
	iwpriv $PHY_IF bintval $BCNINTERVAL
	return 0
