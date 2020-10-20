	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_BW=`syscfg_get "$SYSCFG_INDEX"_radio_band`
	OPMODE=`get_driver_network_mode "$PHY_IF"`
	VHTBW="0"
	if [ "$NET_ANAC_MIXED" = "$OPMODE" ] ; then
		if [ "auto" = "$SYSCFG_BW" ] || [ "wide80" = "$SYSCFG_BW" ] ; then
			VHTBW="1"
		fi
	fi
	
	echo $VHTBW
