    STATE_24=`syscfg get wl0_state`
    STATE_5=`syscfg get wl1_state`
    VAP_24=`syscfg get wl0_user_vap`
    VAP_5=`syscfg get wl1_user_vap`
    WIFI_STA=`syscfg get wifi_sta_user_vap`
    if [ "1" = "`sysevent get wifi_sta_up`" ]; then
    	if [ "$WIFI_STA" = "$VAP_24" ] ; then
    	    STATE_24="down"
    	elif [ "$WIFI_STA" = "$VAP_5" ] ; then
    	    STATE_5="down"
    	fi
    fi
    if [ "up" = "$STATE_24" ] || [ "up" = "$STATE_5" ]; then
    	killall -q acsd
    	ACS_2=`syscfg get wl0_channel`
    	ACS_5=`syscfg get wl1_channel`
        if [ "0" = "$ACS_2" ] && [ "up" = "$STATE_24" ]; then
    	    ACSD_IF_LIST="$VAP_24"
        elif [ "0" != "$ACS_2" ] && [ "up" = "$STATE_24" ] && [ "0" != "`wl -i ${VAP_24} obss_coex`" ] && [ "1" = "`sysevent get coex_acsd`" ] ; then
    	    ACSD_IF_LIST="$VAP_24"
    	fi
    	if [ "0" = "$ACS_5" ] && [ "up" = "$STATE_5" ]; then
    	    if [ "1" != "`syscfg get wifi::band_steering_configure`" ]; then
    	    	ACSD_IF_LIST=`echo "$ACSD_IF_LIST $VAP_5"`
    	    fi
    	fi
    	nvram set acs_ifnames="$ACSD_IF_LIST"
    	/usr/sbin/acsd > /dev/null
    fi
