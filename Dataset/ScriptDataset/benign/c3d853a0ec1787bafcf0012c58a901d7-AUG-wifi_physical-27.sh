	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CHANNEL=`syscfg_get "$SYSCFG_INDEX"_channel`
	if [ "auto" = $SYSCFG_CHANNEL -o "0" = $SYSCFG_CHANNEL ]; then
		echo "Auto channel"
		iwconfig $PHY_IF freq 0
	else
		iwconfig $PHY_IF channel `expr $SYSCFG_CHANNEL`
	fi
	return 0
