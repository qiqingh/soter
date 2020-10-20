	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_STBC=`syscfg_get "$SYSCFG_INDEX"_stbc`
	if [ "$SYSCFG_STBC" = "enabled" ]; then
		STBC=1
	else
		STBC=0
	fi
	echo "$STBC"
