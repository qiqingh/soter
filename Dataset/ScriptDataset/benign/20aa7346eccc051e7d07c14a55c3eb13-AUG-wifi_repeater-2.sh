	echo "${SERVICE_NAME}, prepare()"
	SYSCFG_CHANNEL=`syscfg_get wifi_sta_channel`
    ROOTAP_CHANNEL=`get_rootap_channel $USER_IF "$SSID"`
    CURR_CHANNEL=`get_current_channel $USER_IF`
    echo "syscfg channel: $SYSCFG_CHANNEL, current channel: $CURR_CHANNEL, root AP channel: $ROOTAP_CHANNEL" > /dev/console
    if [ "$ROOTAP_CHANNEL" = "fail" ]; then
        echo "warning: channel of root AP is unknown" > /dev/console
    elif [ "$ROOTAP_CHANNEL" != "$CURR_CHANNEL" -o "$ROOTAP_CHANNEL" != "$SYSCFG_CHANNEL" ]; then
        echo "${SERVICE_NAME}, sync to root AP channel: $ROOTAP_CHANNEL to syscfg" > /dev/console
        syscfg_set wifi_sta_channel $ROOTAP_CHANNEL
        syscfg_set $WLINDEX"_channel" $ROOTAP_CHANNEL
        syscfg_commit
        CHANNEL=$ROOTAP_CHANNEL
    fi
