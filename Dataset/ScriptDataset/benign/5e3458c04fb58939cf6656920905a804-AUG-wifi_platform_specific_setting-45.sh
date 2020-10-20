	PHY_IF=$1
	VALID_SETTING=10
	BAND=`wl -i $PHY_IF band`
	if [ "a" != "$BAND" ]; then
		return
	fi
	wl -i $PHY_IF pspretend_threshold $VALID_SETTING
