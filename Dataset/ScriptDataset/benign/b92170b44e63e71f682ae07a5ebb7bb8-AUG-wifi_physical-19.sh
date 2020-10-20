	PHY_IF=$1
    if [ "`syscfg_get wl_wmm_support`" = "enabled" ]; then
	set_wifi_val $PHY_IF WmmCapable 1
    else
	set_wifi_val $PHY_IF WmmCapable 0
    fi
	return 0
