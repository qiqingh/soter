	WL_SYSCFG=$1
	RET_CODE="0"
	CHIP_TYPE=`syscfg get "$WL_SYSCFG"_chip`
	if [ "$CHIP_TYPE" = "11ac" ]; then
		RET_CODE="1"
	elif [ "$CHIP_TYPE" = "4360" ]; then
		RET_CODE="1"
	fi
	echo "$RET_CODE"
