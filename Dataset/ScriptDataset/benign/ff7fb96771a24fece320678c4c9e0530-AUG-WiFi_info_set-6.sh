	DFS=`syscfg_get wl1_dfs_enabled`
    MULTIREGION_SUPPORT=`syscfg_get wifi::multiregion_support`
    MULTIREGION_ENABLE=`syscfg_get wifi::multiregion_enable`
    if [ "1" = "$MULTIREGION_SUPPORT" -a "1" = "$MULTIREGION_ENABLE" ]; then
        REGION=`syscfg_get wifi::multiregion_region`
        COUNTRY=`syscfg_get wifi::multiregion_selectedcountry`
        OLD_COUNTRY=`sysevent get wifi::multiregion_curr_country`
        if [ -z "$OLD_COUNTRY" ]; then
            OLD_COUNTRY="$COUNTRY"
            sysevent set wifi::multiregion_curr_country "$COUNTRY"
        fi
        echo "Multi region: previous country: $OLD_COUNTRY, new country: $COUNTRY"
        if [ "$COUNTRY" != "$OLD_COUNTRY" ]; then
		echo "*** Selected Country/Region changed, get new channel list ***"
		CH_LIST_2G=`get_2g_ch_list $REGION`
		echo "2.4G channel list of \"$COUNTRY/$REGION\" is $CH_LIST_2G"
		if [ -z "$CH_LIST_2G" ]; then
			echo "Error: Not-recognized region \"$REGION\", get channel list fail!"
			return
		fi
		syscfg_set wl0_available_channels "$CH_LIST_2G"
			CH_LIST_5G=`get_5g_ch_list $REGION`
			echo "5G channel list of \"$COUNTRY/$REGION\" is $CH_LIST_5G"
			if [ -z "$CH_LIST_5G" ]; then
				echo "Error: Not-recognized region \"$REGION\", get channel list fail!"
				return
			fi
			syscfg_set wl1_available_channels "$CH_LIST_5G"
			
		syscfg_commit
		echo "*** Updated channel list to syscfg ***"
            sysevent set wifi::multiregion_curr_country "$COUNTRY"
        else
	        echo "Selected Country is not changed, Do nothing"
        fi
    fi
