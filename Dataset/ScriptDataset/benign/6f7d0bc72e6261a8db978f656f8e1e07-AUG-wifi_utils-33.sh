	PHY_IF=$1
	IGMP=`syscfg_get igmp_enable`
	if [ "1" = "$IGMP" ]; then
		set_wifi_val $PHY_IF IgmpSnEnable 1
	else
		set_wifi_val $PHY_IF IgmpSnEnable 0
	fi
