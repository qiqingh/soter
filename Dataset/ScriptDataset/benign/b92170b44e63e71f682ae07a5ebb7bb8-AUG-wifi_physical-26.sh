	PHY_IF=$1
	BCNINTERVAL=`get_driver_beacon_interval "$PHY_IF"`
	if [ -n $BCNINTERVAL ]; then
		set_wifi_val $PHY_IF BeaconPeriod $BCNINTERVAL
	fi
	return 0
