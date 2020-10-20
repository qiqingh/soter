	PHY_IF=$1
	WLINDEX=`syscfg_get "$PHY_IF"_syscfg_index`
    if [ "`syscfg_get "$WLINDEX"_ht_dup_mcs32`" = "enabled" ]; then
		echo "wifi, $PHY_IF htduplicate enabled"
	set_wifi_val $PHY_IF HT_MCS 33
    fi
	return 0
