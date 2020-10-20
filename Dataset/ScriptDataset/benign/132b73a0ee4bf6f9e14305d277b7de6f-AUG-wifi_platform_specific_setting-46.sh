	PHY_IF=$1
	VALID_SETTING=10
	BAND=`wl -i $PHY_IF band`
	if [ "a" != "$BAND" ]; then
		return
	fi
	if [ "`syscfg get wl1_chip`" = "11ac" ] || [ "`syscfg get wl2_chip`" = "11ac" ]; then
		wl -i $PHY_IF pspretend_threshold $VALID_SETTING
	fi
