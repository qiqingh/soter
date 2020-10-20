	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_BCN_INTERVAL=`syscfg_get "$SYSCFG_INDEX"_beacon_interval`
	if [ -n "$SYSCFG_BCN_INTERVAL" ] && [ $SYSCFG_BCN_INTERVAL -ge 20 ] && [ $SYSCFG_BCN_INTERVAL -le 1000 ]; then
		BCN_INTERVAL=$SYSCFG_BCN_INTERVAL
	else
		BCN_INTERVAL=100
	fi
	echo "$BCN_INTERVAL"
