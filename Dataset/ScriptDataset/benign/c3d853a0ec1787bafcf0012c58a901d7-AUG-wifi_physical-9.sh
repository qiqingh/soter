	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_BW=`syscfg_get "$SYSCFG_INDEX"_radio_band`
	if [ "standard" = "$SYSCFG_BW" ]; then
		HTBW="$HTBW_20MHZ"
	elif [ "wide" = "$SYSCFG_BW" ]; then
		HTBW="$HTBW_40MHZ"
	else
		HTBW="$HTBW_AUTO"
	fi
	if [ "165" = "`syscfg get ${SYSCFG_INDEX}_channel`" ]; then
		HTBW="$HTBW_20MHZ"
	fi
	
	echo $HTBW
