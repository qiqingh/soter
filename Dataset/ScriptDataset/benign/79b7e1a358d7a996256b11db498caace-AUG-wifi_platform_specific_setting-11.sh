	CURRENT_SETTING=`syscfg get wl_access_restriction`
	MAC_ENTRIES=`syscfg get wl_mac_filter`
	IF_LIST=$PHYSICAL_IF_LIST
	GUEST_ENABLED=`syscfg get guest_enabled`
	for j in $IF_LIST;	do
		WL_SYSCFG=`get_syscfg_interface_name $j`
		if [ $WL_SYSCFG = "wl0" ]; then
			WL0_GUEST_IFNAME=`syscfg get wl0_guest_vap`
			WL0_TC_IFNAME=`syscfg get tc_vap_user_vap`
			if [ "$GUEST_ENABLED" = "1" ] && [ "1" = "`syscfg get wl0_guest_enabled`" ] && [ "started" = "`sysevent get wifi_guest-status`" ] ; then
				IF_LIST=`echo "$IF_LIST $WL0_GUEST_IFNAME"`
			fi
			if [ "1" = "`syscfg get tc_vap_enabled`" ] && [ "started" = "`sysevent get wifi_simpletap-status`" ] ; then
				IF_LIST=`echo "$IF_LIST $WL0_TC_IFNAME"`
			fi
		fi
		if [ $WL_SYSCFG = "wl1" ]; then
			WL1_GUEST_IFNAME=`syscfg get wl1_guest_vap`
			if [ "$GUEST_ENABLED" = "1" ] && [ "1" = "`syscfg get wl1_guest_enabled`" ] && [ "started" = "`sysevent get wifi_wl1_guest-status`" ] ; then
				IF_LIST=`echo "$IF_LIST $WL1_GUEST_IFNAME"`
			fi
		fi
	done
	if [ "$CURRENT_SETTING" = "allow" ] || [ "$CURRENT_SETTING" = "deny" ]; then
		for if_name in $IF_LIST; do
			wl -i $if_name macmode 0
	 		wl -i $if_name mac none
	 		if [ -n "$MAC_ENTRIES" ]; then
				wl -i $if_name mac $MAC_ENTRIES
			fi
			if [ "$CURRENT_SETTING" = "allow" ]; then
				wl -i $if_name macmode 2
			else
				wl -i $if_name macmode 1
			fi
		done
		sysevent set wl_mac_filter-errinfo "Successful add MAC filter entries"
		sysevent set wl_mac_filter-status "started"
	else
		for if_name in $IF_LIST; do
			wl -i $if_name macmode 0
			wl -i $if_name mac none
		done
		sysevent set wl_mac_filter-errinfo "MAC filter is disabled"
		sysevent set wl_mac_filter-status "started"
	fi
