	PHY_IF=$1
    if [ "`syscfg_get wl_wmm_support`" = "enabled" ]; then
        iwpriv $PHY_IF wmm 1
    else
        iwpriv $PHY_IF wmm 0
    fi
	return 0
