    ACS_2=`syscfg get wl0_channel`
    ACS_5=`syscfg get wl1_channel`
    state_24=`syscfg get wl0_state`
    state_5=`syscfg get wl1_state`
    if [ "up" = "$state_24" ] || [ "up" = "$state_5" ]; then
	killall -q acsd
	VAP_24=`syscfg get wl0_user_vap`
	VAP_5=`syscfg get wl1_user_vap`
    	network_24=`get_network_mode $VAP_24`
    	network_5=`get_network_mode $VAP_5`
        if [ "0" = "$ACS_2" ] && [ "up" = "$state_24" ]; then
	    ACSD_IF_LIST="$VAP_24"
	    translate_index "wl0"
	    nvram_index=$?
	    nvram set wl${nvram_index}_chanspec=0
	    nvram set wl${nvram_index}_nmode=0
	    is_nmode=`is_nmode "${network_24}"`
	    if [ $is_nmode = 1 ]; then
	        nvram set wl${nvram_index}_nmode=-1
	    fi
	fi
	if [ "0" = "$ACS_5" ] && [ "up" = "$state_5" ]; then
	    ACSD_IF_LIST=`echo "$ACSD_IF_LIST $VAP_5"`
	    translate_index "wl1"
	    nvram_index=$?
	    nvram set wl${nvram_index}_chanspec=0
	    nvram set wl${nvram_index}_nmode=0
	    is_nmode=`is_nmode "${network_5}"`
	    if [ $is_nmode = 1 ]; then
	        nvram set wl${nvram_index}_nmode=-1
	    fi
	fi
	
	nvram set wl_nmode=-1
	nvram set acs_ifnames="$ACSD_IF_LIST"
	nvram commit
	/usr/sbin/acsd > /dev/null &
	sleep 2
	if [ "0" = "$ACS_2" ] && [ "up" = "$state_24" ]; then
	    /usr/sbin/acs_cli -i $VAP_24 autochannel
        fi   
	if [ "0" = "$ACS_5" ] && [ "up" = "$state_5" ]; then
	    /usr/sbin/acs_cli -i $VAP_5 autochannel
	fi
    fi
