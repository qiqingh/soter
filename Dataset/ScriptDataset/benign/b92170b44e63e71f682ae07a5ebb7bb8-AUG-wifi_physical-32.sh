	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CHANNEL=`syscfg_get "$SYSCFG_INDEX"_channel`
	if [ "auto" = $SYSCFG_CHANNEL -o "0" = $SYSCFG_CHANNEL ]; then
                set_wifi_val $PHY_IF AutoChannelSelect 3
                set_wifi_val $PHY_IF Channel 0
	else
		set_wifi_val $PHY_IF AutoChannelSelect 0
		set_wifi_val $PHY_IF Channel $SYSCFG_CHANNEL
	fi
	return 0
