	PHY_IF=$1
    if [ "`syscfg_get wl_mcastenhance_support`" = "enabled" ]; then
        iwpriv $PHY_IF mcastenhance 2
    else
        iwpriv $PHY_IF mcastenhance 0
    fi
	return 0
