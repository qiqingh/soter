	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	DFS=`syscfg_get "$SYSCFG_INDEX"_dfs_enabled`
	SYSCFG_REGION_CODE=`syscfg_get device::cert_region`
	if [ "$SYSCFG_INDEX" = "wl1" -a "$DFS" = "1" ]; then
               if [ "$SYSCFG_REGION_CODE" = "EU" -o "$SYSCFG_REGION_CODE" = "ME" ]; then
                       echo "wifi, DFS enabled"
                       set_wifi_val $PHY_IF IEEE80211H "1"
                       set_wifi_val $PHY_IF RDRegion "CE"
                       set_wifi_val $PHY_IF DfsEnable "1"
                       set_wifi_val $PHY_IF AutoChannelSkipList "116;120;124;128"
               else
                       echo "wifi, DFS disabled"
                       set_wifi_val $PHY_IF IEEE80211H "0"
                       set_wifi_val $PHY_IF RDRegion ""
                       set_wifi_val $PHY_IF DfsEnable "0"
                       set_wifi_val $PHY_IF AutoChannelSkipList ""
               fi
	else
        echo "wifi, DFS disabled"
		set_wifi_val $PHY_IF IEEE80211H "0"
		set_wifi_val $PHY_IF RDRegion ""
		set_wifi_val $PHY_IF DfsEnable "0"
		set_wifi_val $PHY_IF AutoChannelSkipList ""
	fi
