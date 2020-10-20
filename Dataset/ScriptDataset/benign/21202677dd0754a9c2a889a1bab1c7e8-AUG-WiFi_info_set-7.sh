    DFS=`syscfg_get wl1_dfs_enabled`
    SYSCFG_REGION_CODE=`syscfg_get device::cert_region`
    MULTIREGION_SUPPORT=`syscfg_get wifi::multiregion_support`
    MULTIREGION_ENABLE=`syscfg_get wifi::multiregion_enable`
    wl1_available_channels=`syscfg_get wl1_available_channels`
    REGION=""
    COUNTRY=""
    
	if [ "$DFS" = "1" ]; then
		if [ "1" = "$MULTIREGION_SUPPORT" -a "1" = "$MULTIREGION_ENABLE" ]; then
			echo "${SERVICE_NAME}, Multi-region is supported and enabled"
			REGION=`syscfg_get wifi::multiregion_region`
			COUNTRY=`syscfg_get wifi::multiregion_selectedcountry`
			echo "${SERVICE_NAME}, Region: $REGION, Country: $COUNTRY"
		else
			echo "${SERVICE_NAME}, Multi-region is not supported or not enabled"
			REGION=`syscfg_get device::cert_region`
			echo "${SERVICE_NAME}, Cert region: $REGION"
		fi
		if [ "$COUNTRY" ]; then
			if [ "XME" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS" ]; then #Middle East
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "SAU" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS" ]; then #Middle East- Saudi Arabia
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "ARE" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS1" ]; then #Middle East- United Arab Emirates
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS1, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS1"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "BHR" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS2" ]; then #Middle East- Bahrain
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS2, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS2"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "EGY" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS2" ]; then #Middle East- Egypt
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS2, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS2"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "KWT" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS2" ]; then #Middle East- Kuwait
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS2, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS2"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "OMN" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS2" ]; then #Middle East- Oman
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS2, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS2"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "QAT" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS2" ]; then #Middle East- Qatar
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS2, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS2"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "TUR" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS3" ]; then #Middle East- Turkey
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS3, update it."
				syscfg_set wl1_available_channels "$ME_CH_LIST_5G_DFS3"
				syscfg_set wl1_channel 0
			    syscfg_commit
			elif [ "EEE" = "$COUNTRY" -a "$wl1_available_channels" != "$ME_CH_LIST_5G_DFS3" ]; then #Europe
				echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $ME_CH_LIST_5G_DFS3, update it."
				syscfg_set wl1_available_channels "$EU_CH_LIST_5G_DFS"
				syscfg_set wl1_channel 0
			    syscfg_commit
                        elif [ "CAN" = "$COUNTRY" -a "$wl1_available_channels" != "$CA_CH_LIST_5G" ]; then #Canada
                                echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $CA_CH_LIST_5G, update it."
                                syscfg_set wl1_available_channels "$CA_CH_LIST_5G"
                                syscfg_set wl1_channel 0
                            syscfg_commit
                        elif [ "USA" = "$COUNTRY" -a "$wl1_available_channels" != "$US_CH_LIST_5G" ]; then #United States
                                echo "DFS enabled, current channel list is ${wl1_available_channels}, it should be $US_CH_LIST_5G, update it."
                                syscfg_set wl1_available_channels "$US_CH_LIST_5G"
                                syscfg_set wl1_channel 0
                            syscfg_commit
			else
				echo "channel list does not change".
			fi
		fi
    fi
