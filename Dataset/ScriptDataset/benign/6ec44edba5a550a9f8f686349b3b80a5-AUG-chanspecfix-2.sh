    channel_wl0="0"
    channel_wl1="0"
    if [ "1" = "`sysevent get wifi_sta_up`" ]; then
    	WIFI_STA=`syscfg get wifi_sta_user_vap`
    	VIR_IFNAME=`get_syscfg_interface_name $WIFI_STA`
    	eval channel_$VIR_IFNAME="1"
    fi
    FIX_TRY="0"
    sysevent set coex_acsd 0
    nvram unset acs_ifnames
    killall -q acsd
